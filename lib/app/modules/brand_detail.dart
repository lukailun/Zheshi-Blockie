// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/issuer.dart';
import 'package:blockie_app/models/project_group.dart';
import 'package:blockie_app/models/project_group_load_info.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/project_item.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({Key? key}) : super(key: key);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  Issuer? _issuerInfo;
  String? _nextPageUrl;
  final _projectGroups = <ProjectGroup>[];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      Issuer issuerInfo =
          await HttpRequest.loadIssuerDetail(uid: Get.parameters["issuerUid"]!);
      setState(() {
        _issuerInfo = issuerInfo;
        _addProjects(uid: _issuerInfo!.id);
      });
    });
    super.initState();
  }

  void _addProjects({String? uid}) {
    Future.delayed(Duration.zero, () async {
      ProjectGroupLoadInfo projectGroupLoadInfo =
          await HttpRequest.loadBrandGroups(
              pageUrl: _nextPageUrl, issuerUid: uid);
      _nextPageUrl = projectGroupLoadInfo.nextPageUrl;
      setState(() {
        _projectGroups.insertAll(
            _projectGroups.length, projectGroupLoadInfo.projectGroups);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_issuerInfo == null) {
      return const Material(
        color: AppThemeData.primaryColor,
        child: SizedBox(),
      );
    }

    Widget brandInfo = Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(
              _issuerInfo == null ? '' : _issuerInfo!.logoUrl ?? ''),
        ),
        Container(
          padding: const EdgeInsets.only(top: 7, bottom: 11),
          child: Text(
            _issuerInfo == null ? '' : _issuerInfo!.title,
            style: const TextStyle(color: Color(0xffffffff), fontSize: 16),
          ),
        )
      ],
    );

    Widget brandIntro = Center(
      child: Text(
        _issuerInfo!.summary ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xccffffff), fontSize: 14),
      ),
    ).paddingAll(15).outlined().paddingOnly(bottom: 22);

    const projectTitleStyle = TextStyle(color: Color(0xffffffff), fontSize: 16);

    Widget brandCardTitle = Container(
      padding: const EdgeInsets.only(bottom: 8, top: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "品牌项目",
            style: projectTitleStyle,
          ),
          Text(
            "共${_projectGroups.length}个",
            style: projectTitleStyle,
          )
        ],
      ),
    );

    Widget brandCards = SizedBox(
      child: ListView.builder(
          itemCount: _projectGroups.length + 1,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            //如果到了表尾
            if (index == _projectGroups.length) {
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
                  ).paddingOnly(bottom: 15),
                );
              }
            }
            return createProjectItemMixed(_projectGroups[index],
                showBrand: false);
          }),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: BasicAppBar(),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          brandInfo,
          brandIntro,
          brandCardTitle,
          brandCards,
        ],
      ),
    );
  }
}
