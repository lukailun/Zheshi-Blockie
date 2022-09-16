import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:blockie_app/common/global.dart';
import 'package:blockie_app/common/issuer_info.dart';
import 'package:blockie_app/common/project_info.dart';
import 'package:blockie_app/common/project_load_info.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/common/routes.dart';
import 'package:get/get.dart';


class BrandPage extends StatefulWidget{
  const BrandPage({Key? key}) : super(key: key);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage>{
  IssuerInfo? _issuerInfo;
  String? _nextPageUrl;
  final _projects = <ProjectInfo>[];

  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      setState(() {
        // _issuerInfo = ModalRoute.of(context)!.settings.arguments as IssuerInfo;
        _issuerInfo = IssuerInfo.fromJson(jsonDecode(Get.parameters["issuer"]!));
        _addProjects(uid: _issuerInfo!.uid);
      });
    });
    super.initState();
  }

  void _addProjects({String? uid}) {
    Future.delayed(Duration.zero, () async {
      ProjectLoadInfo projectLoadInfo = await HttpRequest.loadBrandProjects(pageUrl: _nextPageUrl, issuerUid: uid);
      _nextPageUrl = projectLoadInfo.nextPageUrl;
      setState(() {
        _projects.insertAll(_projects.length, projectLoadInfo.projects);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_issuerInfo == null) {
      return const Material(
        color: Color(0xff3C63F8),
        child: SizedBox(),
      );
    }
    Widget _createBrandCard(ProjectInfo projectInfo) {
      return GestureDetector(
        onTap: (){
          // Navigator.of(context).pushNamed("/project", arguments: projectInfo.uid);
          Get.toNamed("${Routes.project}?projectUid=${projectInfo.uid}");
        },
        child: Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/HomeCardOutline.png"),
                fit: BoxFit.fill,
              ),
            ),
            width: 332,
            height: 450,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: Image.network(
                        projectInfo.cover,
                        // width: 332,
                        // height: 250s,
                        fit: BoxFit.contain,
                      ),
                    )
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 5),
                              child: Text(
                                projectInfo.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          // height: 20,
                          child: Text(
                            projectInfo.summary,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xb3ffffff)
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ],),
            )
        ),
      );
    }

    Widget topButton = Container(
      padding: const EdgeInsets.only(left: 19, right: 19, top: Global.titleButtonTop, bottom: 10),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              }, // Image tapped
              child: Image.asset(
                "images/back.png",
                width: 29,
                height: 29,
              )
          )
        ],
      ),
    );

    Widget brandInfo = Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(
              _issuerInfo == null ? '' : _issuerInfo!.logo
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 7, bottom: 11),
          child: Text(
            _issuerInfo == null ? '' : _issuerInfo!.title,
            style: const TextStyle(
              color: Color(0xffffffff),
              fontSize: 16
            ),
          ),
        )
      ],
    );

    Widget brandIntro = Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 22),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/BrandIntroOutline.png"),
          fit: BoxFit.fill,
        ),
      ),
      width: 332,
      height: 62,
      child: Center(
        child: Text(
          _issuerInfo!.summary,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color(0xccffffff),
              fontSize: 14
          ),
        ),
      ),
    );

    const projectTitleStyle = TextStyle(
        color: Color(0xffffffff),
        fontSize: 16
    );

    Widget brandCardTitle = Container(
      padding: const EdgeInsets.only(left: 22, right: 22, bottom: 8, top: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "品牌项目",
            style: projectTitleStyle,
          ),
          Text(
            "共${_projects.length}个",
            style: projectTitleStyle,
          )
        ],
      ),
    );

    Widget brandCards = SizedBox(
      width: 400,
      child: ListView.builder(
          itemCount: _projects.length + 1,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            //如果到了表尾
            if (index == _projects.length) {
              if (_nextPageUrl != null) {
                _addProjects();
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "没有更多了",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
            }
            return _createBrandCard(_projects[index]);
          }
      ),
    );

    return Material(
        color: const Color(0xff3C63F8),
        child: ListView(
          shrinkWrap: true,
          children: [
            topButton,
            brandInfo,
            brandIntro,
            brandCardTitle,
            brandCards
          ],
        )
    );
  }
}