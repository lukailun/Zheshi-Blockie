// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/models/project_group.dart';
import 'package:blockie_app/models/project_group_load_info.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/license_dialog.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:blockie_app/widgets/project_item.dart';

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
    AnyWebService.to.accountsCode.listen((event) {
      if (event.isSuccessful) {
        _login(event.data as String);
      } else {
        setState(() {
          _showLoginPanel = false;
        });
      }
    });
    AnyWebService.to.logout.listen((_) {
      DataStorage.setToken('');
      _updateUser();
    });
    _updateUser();
    _addProjects();
  }

  void _showLicenseDialog() {
    Get.dialog(LicenseDialog(
      onTermsOfServiceTap: () {
        final parameters = {
          WebViewParameter.url: BlockieUrlBuilder.buildTermsOfServiceUrl(),
        };
        Get.toNamed(Routes.webView, parameters: parameters);
      },
      onPrivacyPolicyTap: () {
        final parameters = {
          WebViewParameter.url: BlockieUrlBuilder.buildPrivacyPolicyUrl(),
        };
        Get.toNamed(Routes.webView, parameters: parameters);
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
    ui.platformViewRegistry.registerViewFactory(AnyWebMethod.accounts.value,
        (int viewId) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src =
            'https://zheshi.tech/public/dist/?method=${AnyWebMethod.accounts.value}'
        ..style.border = 'none';
    });

    final loginLoadingIndicator =
        HtmlElementView(viewType: AnyWebMethod.accounts.value);

    final listView = ListView.builder(
        itemCount: _projectGroups.length + 1,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          //如果到了表尾
          if (index == _projectGroups.length) {
            if (_nextPageUrl != null) {
              _addProjects();
              return Container(
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
                child: const Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              ).paddingOnly(bottom: 20);
            }
          }
          return createProjectItemMixed(_projectGroups[index],
              whenBack: _updateUser);
        });
    final avatar = GestureDetector(
      onTap: () {
        if (_userInfo == null) {
          _showLicenseDialog();
        } else {
          final parameters = {
            'uid': _userInfo?.uid ?? "",
          };
          Get.toNamed(Routes.user, parameters: parameters);
        }
      }, // Image tapped
      child: CircleAvatar(
        radius: 25,
        backgroundImage:
            _userInfo == null ? null : NetworkImage(_userInfo!.avatar),
        backgroundColor: Colors.grey,
        child: Text(
          _userInfo == null ? "登录" : "",
          style: const TextStyle(color: Color(0xb3ffffff), fontSize: 14),
        ),
      ),
    ).paddingOnly(right: 10);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: !_showLoginPanel
          ? BasicAppBar(
              showsLogo: true,
              avatar: avatar,
            )
          : null,
      body: Stack(
        children: [
          Container(
            child: listView,
          ),
          if (_showLoginPanel) loginLoadingIndicator
        ],
      ),
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
      ProjectGroupLoadInfo projectGroupLoadInfo =
          await HttpRequest.loadProjectGroups(pageUrl: _nextPageUrl);
      _nextPageUrl = projectGroupLoadInfo.nextPageUrl;
      setState(() {
        _projectGroups.insertAll(
            _projectGroups.length, projectGroupLoadInfo.projectGroups);
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
    } catch (e) {
      if (DataStorage.getToken() != null) {
        UserInfo userInfo =
            await HttpRequest.getUserInfo(DataStorage.getToken()!);
        AuthService.to.updateUserInfo(userInfo);
        setState(() {
          _showLoginPanel = false;
          _userInfo = userInfo;
        });
      }
    }
  }
}
