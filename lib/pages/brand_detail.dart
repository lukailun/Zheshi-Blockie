import 'dart:convert';

import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:blockie_app/common/global.dart';
import 'package:blockie_app/common/issuer_info.dart';
import 'package:blockie_app/common/project_info.dart';
import 'package:blockie_app/common/project_load_info.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:blockie_app/widgets/screen_bound.dart';
import 'package:blockie_app/widgets/project_item.dart';

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
    Future.delayed(Duration.zero,() async {
      IssuerInfo issuerInfo = await HttpRequest.loadIssuerDetail(uid: Get.parameters["issuerUid"]!);
      setState(() {
        _issuerInfo = issuerInfo;
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
          margin: const EdgeInsets.only(bottom: 32),
          child: ProjectItem(projectGroup: null, projectInfo: projectInfo,
          showBrand: false,),
        ),
      );
    }

    Widget topButton = Container(
      padding: const EdgeInsets.only(right: 19, top: Global.titleButtonTop, bottom: 10),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              }, // Image tapped
              child: Image.asset(
                "images/back.png",
                width: 40,
                height: 40,
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

    Widget brandIntro = SizedBox(
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
    ).outlined().paddingOnly(bottom: 22);

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
                  // padding: const EdgeInsets.all(16.0),
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
                  // padding: const EdgeInsets.all(16.0),
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

    // return Material(
    //     color: const Color(0xff3C63F8),
    //     child: ListView(
    //       shrinkWrap: true,
    //       children: [
    //         topButton,
    //         brandInfo,
    //         brandIntro,
    //         brandCardTitle,
    //         brandCards
    //       ],
    //     )
    // );
    return ScreenBoundary(
        body: ListView(
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