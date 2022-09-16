import 'dart:convert';
import 'dart:ui';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:blockie_app/common/project_group.dart';
import 'package:blockie_app/common/project_group_load_info.dart';
import 'package:blockie_app/common/user_info.dart';
import 'package:blockie_app/pages/camera.dart';
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
import 'package:get/get.dart';

class ProjectGroups extends StatefulWidget {
  const ProjectGroups({Key? key}) : super(key: key);

  @override
  _ProjectGroupsState createState() => _ProjectGroupsState();
}

class _ProjectGroupsState extends State<ProjectGroups> {
  final _projectGroups = <ProjectGroup>[];
  String? _nextPageUrl;
  UserInfo? _userInfo;
  bool _showLoginPanel = false;
  // late Future<ProjectLoadInfo> _futureProjects;

  @override
  void initState() {
    super.initState();
    html.window.onMessage.listen((event) {
      var data = jsonDecode(event.data);
      if (data["status"] != "ok") {
        throw Exception("登录错误${data["code"]}");
      }
      String code = data["data"]["code"];
      _login(code);
    });
    _updateUser();
    // _futureProjects = HttpRequest.loadNewProjects();
    _addProjects();
  }

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('login', (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = 'https://zheshi.tech/public/dist/?method=cfx_accounts'
        ..style.border = 'none';
    });

    Widget loginPanel = Container(
      color: const Color(0x80ffffff),
      child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: const HtmlElementView(viewType: 'login'),
                ),
              ),
              Positioned(
                  right: 23,
                  top: Global.titleButtonTop,
                  child: GestureDetector(
                      onTap: () {
                        _switchLoginPanel(false);
                      }, // Image tapped
                      child: Image.asset(
                        "images/close_panel.png",
                        width: 29,
                        height: 29,
                      )
                  )
              )
            ],
          )
      ),
    );

    Widget title = Container(
      padding: const EdgeInsets.only(left: 35, right: 32, top: 30, bottom: 20),
      child: Row(
          children: [
            Image.asset(
              'images/blockie.png',
              fit: BoxFit.contain,
              height: 23,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (_userInfo == null) {
                  _switchLoginPanel(true);
                } else {
                  // Navigator.of(context).pushNamed("/user", arguments: _userInfo);
                  Get.toNamed("${Routes.user}?user=${jsonEncode(_userInfo!.json)}");
                }
              }, // Image tapped
              child: CircleAvatar(
                radius: 25,
                backgroundImage: _userInfo == null ? null : NetworkImage(
                  _userInfo!.avatar
                ),
                backgroundColor: Colors.grey,
              )
            )
          ],
      ),
    );

    Widget listView = Container(
      width: 400,
      child: ListView.builder(
          itemCount: _projectGroups.length + 2,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return title;
            }
            //如果到了表尾
            if (index == _projectGroups.length + 1) {
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
            return _createProjectItem(_projectGroups[index - 1]);
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
            _showLoginPanel ? loginPanel : const SizedBox(height: 0,)
          ],
        ),
      )
    );
  }

  GestureDetector _createProjectItem(ProjectGroup projectGroupData) {
    ProjectInfo? projectInfo;
    ProjectGroup? projectGroup;
    if (projectGroupData.projects.length == 1) {
      projectInfo = projectGroupData.projects[0];
    } else {
      projectGroup = projectGroupData;
    }
    String url = projectInfo == null ? "${Routes.projects}?projectGroup=${jsonEncode(projectGroup!.json)}" :
    "${Routes.project}?projectUid=${projectInfo.uid}";
    return GestureDetector(
      onTap: () {
        Get.toNamed(url)?.then((_){
          _updateUser();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
        child: ProjectItem(projectGroup: projectGroup, projectInfo: projectInfo, width: 332, height: 462),
      )
    );
  }

  void _switchLoginPanel(bool show) {
    Get.to(const CameraApp());
  }

  void _updateUser() async {
    if (DataStorage.getToken() != null) {
      UserInfo res = await HttpRequest.getUserInfo(DataStorage.getToken()!);
      setState(() {
        _userInfo = res;
      });
    }
  }

  void _addProjects() {
    Future.delayed(Duration.zero, () async {
      ProjectGroupLoadInfo projectGroupLoadInfo = await HttpRequest.loadProjectGroups(pageUrl: _nextPageUrl);
      _nextPageUrl = projectGroupLoadInfo.nextPageUrl;
      setState(() {
        _projectGroups.insertAll(_projectGroups.length, projectGroupLoadInfo.projectGroups);
      });
    });
  }

  void _login(String code) async {
    try {
      String token = await HttpRequest.login(code);
      DataStorage.setToken(token);
      UserInfo userInfo = await HttpRequest.getUserInfo(token);
      Future.delayed(Duration.zero, (){
        setState(() {
          _showLoginPanel = false;
          _userInfo = userInfo;
        });
      });
      MessageToast.showMessage("登录成功");
    } catch(e) {
      print(e.toString());
      if (DataStorage.getToken() != null) {
      }
      Future.delayed(Duration.zero, () async {
        UserInfo userInfo = await HttpRequest.getUserInfo(DataStorage.getToken()!);
        setState(() {
          _showLoginPanel = false;
          _userInfo = userInfo;
        });
      });
    }
  }
}

