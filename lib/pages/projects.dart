import 'dart:convert';
import 'dart:ui';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:blockie_app/common/project_group.dart';
import 'package:blockie_app/common/user_info.dart';
import 'package:blockie_app/widgets/description_text.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:blockie_app/common/global.dart';
import 'package:blockie_app/common/project_info.dart';
import 'package:blockie_app/common/project_load_info.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blockie_app/common/routes.dart';
import 'package:get/get.dart';
import 'package:blockie_app/widgets/project_item.dart';

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
    Future.delayed(Duration.zero,() async {
      setState(() {
        projectGroup = ProjectGroup.fromJson(jsonDecode(Get.parameters["projectGroup"]!));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (projectGroup == null) {
      return const Material(color: Color(0xff3C63F8));
    }

    Widget title = Container(
      padding: const EdgeInsets.only(left: 21, right: 22, top: Global.titleButtonTop, bottom: 20),
      child: Column(
        children: [
          Row(
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16, bottom: 15),
                child: Text(
                  projectGroup!.name,
                  style: const TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 24
                  ),
                ),
              )
            ],
          ),
          DescriptionTextWidget(text: projectGroup!.summary, minLines: 3,)
        ],
      ),
    );

    Widget listView = Container(
      width: 400,
      child: ListView.builder(
          itemCount: projectGroup!.projects.length + 2,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return title;
            }
            //如果到了表尾
            if (index == projectGroup!.projects.length + 1) {
              return const SizedBox(height: 16,);
            }
            return _createProjectItem(projectGroup!.projects[index - 1]);
          }
      ),
    );

    return Material(
        color: const Color(0xff3C63F8),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              listView,
            ],
          ),
        )
    );
  }

  GestureDetector _createProjectItem(ProjectInfo projectInfo) {
    return GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed("/project", arguments: projectInfo.uid).then((_){
          //   _updateUser();
          // });
          Get.toNamed("${Routes.project}?projectUid=${projectInfo.uid}");
        },
        child: Container(
          margin: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
          child: ProjectItem(projectInfo: projectInfo, width: 332, height: 462),
        )
    );
  }
}

