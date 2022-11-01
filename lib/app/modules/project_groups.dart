// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/environment.dart';
import 'package:blockie_app/models/project_group.dart';
import 'package:blockie_app/models/project_group_load_info.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
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

  @override
  void initState() {
    super.initState();
    AnyWebService.to.logout.listen((_) {
      DataStorage.setToken('');
      _updateUser();
    });
    _updateUser();
    _addProjects();
    if (Environment.environment == "DEVELOPMENT") {
      showDebugBtn(context);
    }
  }

  void _showLicenseDialog() {
    Get.licenseDialog(onLoginSuccess: () {
      _updateUser();
      MessageToast.showMessage("登录成功");
    });
  }

  @override
  Widget build(BuildContext context) {
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
            ProfileParameter.id: _userInfo?.uid ?? "",
          };
          Get.toNamed(Routes.profile, parameters: parameters);
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
      appBar: BasicAppBar(
        showsLogo: true,
        avatar: avatar,
      ),
      body: listView,
    );
  }

  void _updateUser() async {
    if ((DataStorage.getToken() ?? "").isNotEmpty) {
      UserInfo res = await HttpRequest.getUserInfo(DataStorage.getToken()!);
      AuthService.to.user.value = res;
      AuthService.to.login();

      setState(() {
        _userInfo = res;
      });
    } else {
      AuthService.to.user.value = null;
      AuthService.to.logout();
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
}
