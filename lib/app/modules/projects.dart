// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/get_extension.dart';
import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/project_group.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/description_text.dart';
import 'package:blockie_app/widgets/project_item.dart';
import 'package:blockie_app/widgets/screen_bound.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  ProjectGroup? projectGroup;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      ProjectGroup group = await HttpRequest.loadProjectGroup(
          groupUid: Get.jsonParameters["groupUid"]!);
      setState(() {
        projectGroup = group;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (projectGroup == null) {
      return const Material(color: Color(0xff3C63F8));
    }

    Widget title = Container(
      padding:
          const EdgeInsets.only(top: 80 - Global.titleButtonTop, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16, bottom: 15),
                child: Text(
                  projectGroup!.name,
                  style:
                      const TextStyle(color: Color(0xffffffff), fontSize: 24),
                ),
              )
            ],
          ),
          DescriptionTextWidget(
            text: projectGroup!.summary,
            minLines: 3,
          )
        ],
      ),
    );

    Widget listView = ListView.builder(
        itemCount: projectGroup!.projects.length + 2,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return title;
          }
          //如果到了表尾
          if (index == projectGroup!.projects.length + 1) {
            return const SizedBox(
              height: 16,
            );
          }
          return createProjectItemSingle(projectGroup!.projects[index - 1]);
        });

    return ScreenBoundary(
        padding: 0,
        body: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: BasicAppBar(),
          body: listView.paddingSymmetric(horizontal: 20),
        ));
  }
}
