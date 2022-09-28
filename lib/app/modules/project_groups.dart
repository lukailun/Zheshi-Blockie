import 'dart:ui';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:blockie_app/models/project_group.dart';
import 'package:blockie_app/models/project_group_load_info.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:blockie_app/widgets/project_item.dart';
import 'package:blockie_app/widgets/screen_bound.dart';

import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/widgets/license_dialog.dart';

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
    AnyWebService.to.accountsCode
    .listen((event) {
      if (event.isSuccessful) {
        _login(event.data as String);
      } else {
        setState(() {
          _showLoginPanel = false;
        });
      }
    });
    AnyWebService.to.logout
        .listen((_) {
      DataStorage.setToken('');
      _updateUser();
    });
    _updateUser();
    // _futureProjects = HttpRequest.loadNewProjects();
    _addProjects();
  }

  void _showLicenseDialog() {
    Get.dialog(LicenseDialog(
      onTermsOfServiceTap: () {
        Get.back();
      },
      onPrivacyPolicyTap: () {
        Get.back();
      },
      onPositiveButtonTap: () {
        Get.back();
        _switchLoginPanel(true);
      },
      onNegativeButtonTap: () => Get.back(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(AnyWebMethod.accounts.value, (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = 'https://zheshi.tech/public/dist/?method=${AnyWebMethod.accounts.value}'
        ..style.border = 'none';
    });

    final loginLoadingIndicator = HtmlElementView(viewType: AnyWebMethod.accounts.value);

    Widget title = Container(
      // padding: const EdgeInsets.only(left: 35, right: 32, top: 30, bottom: 20),
      padding: const EdgeInsets.only(top: 30, bottom: 20, left: 3),
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
                  _showLicenseDialog();
                } else {
                  Get.toNamed(Routes.faceVerification);
                  // Get.toNamed("${Routes.user}?uid=${_userInfo!.uid}");
                }
              }, // Image tapped
              child: CircleAvatar(
                radius: 25,
                backgroundImage: _userInfo == null ? null : NetworkImage(
                  _userInfo!.avatar
                ),
                backgroundColor: Colors.grey,
                child: Text(
                  _userInfo == null ? "登录" : "",
                  style: const TextStyle(
                    color: Color(0xb3ffffff),
                    fontSize: 14
                  ),
                ),
              )
            )
          ],
      ),
    );
    
    Widget listView = Container(
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
            return createProjectItemMixed(_projectGroups[index - 1], whenBack: _updateUser);
          }
      ),
    );

    return ScreenBoundary(
      padding: 0,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: listView,
          ),
          if (_showLoginPanel) loginLoadingIndicator
        ],
      )
    );
  }


  void _switchLoginPanel(bool show) {
    setState(() {
      _showLoginPanel = show;
    });
  }

  void _updateUser() async {
    if ((DataStorage.getToken() ?? "").isNotEmpty) {
      UserInfo res = await HttpRequest.getUserInfo(DataStorage.getToken()!);
      AuthService.to.updateUserInfo(res);
      setState(() {
        _userInfo = res;
      });
    } else {
      AuthService.to.updateUserInfo(null);
      setState(() {
        _userInfo = null;
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
      Map<String, dynamic> res = await HttpRequest.login(code);
      String token = res['token'];
      UserInfo userInfo = res['user'];
      DataStorage.setToken(token);
      DataStorage.setUserUid(userInfo.uid);
      AuthService.to.updateUserInfo(userInfo);
      setState(() {
        _showLoginPanel = false;
        _userInfo = userInfo;
      });
      MessageToast.showMessage("登录成功");
    } catch(e) {
      if (DataStorage.getToken() != null) {
        UserInfo userInfo = await HttpRequest.getUserInfo(DataStorage.getToken()!);
        AuthService.to.updateUserInfo(userInfo);
        setState(() {
          _showLoginPanel = false;
          _userInfo = userInfo;
        });
      }
    }
  }
}

