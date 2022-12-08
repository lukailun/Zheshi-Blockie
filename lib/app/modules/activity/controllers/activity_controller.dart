// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/bindings/subactivity_binding.dart';
import 'package:blockie_app/app/modules/activity/models/activity.dart';
import 'package:blockie_app/app/modules/brand_details/controllers/brand_details_controller.dart';
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/app/modules/registration_info/controllers/registration_info_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/models/wechat_share_source.dart';
import 'package:blockie_app/data/models/wechat_shareable.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/get_dialog_extension.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class ActivityController extends GetxController
    with GetSingleTickerProviderStateMixin, WechatShareable {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;
  final activity = Rxn<Activity>();
  final headerIsExpanded = true.obs;

  ActivityController({
    required this.accountRepository,
    required this.projectRepository,
  });

  TabController? tabController;

  final id = Get.rootDelegate.parameters[ActivityParameter.id] as String;

  @override
  void onReady() {
    super.onReady();
    getActivity();
  }

  @override
  void onClose() {
    super.onClose();
    isDefaultConfig = true;
    wechatReadyStream?.cancel();
    wechatReadyStream = null;
  }

  void getUserInfo() async {
    if ((DataStorage.getToken() ?? '').isNotEmpty) {
      final user = await accountRepository.getUserInfo();
      AuthService.to.userInfo.value = user;
      AuthService.to.login();
    } else {
      AuthService.to.userInfo.value = null;
      AuthService.to.logout();
    }
  }

  void goToRegistrationInfo(String activityId) async {
    final parameters = {
      RegistrationInfoParameter.id: activityId,
    };
    await Get.toNamed(Routes.registrationInfo, parameters: parameters);
    getActivity();
  }

  void goToProjectDetails(String id) async {
    final parameters = {ProjectDetailsParameter.id: id};
    await Get.toNamed(Routes.projectDetails, parameters: parameters);
    getActivity();
  }

  void goToBrandDetails(String id) async {
    final parameters = {BrandDetailsParameter.id: id};
    await Get.toNamed(Routes.brand, parameters: parameters);
    getActivity();
  }

  void getActivity() async {
    activity.value = await projectRepository.getActivity(id);
    final activityValue = activity.value;
    if (activityValue == null || activityValue.subactivityPreviews.isEmpty) {
      return;
    }
    tabController = TabController(
        length: activityValue.subactivityPreviews.length, vsync: this);
    activityValue.subactivityPreviews.forEach((it) {
      SubactivityBinding(
              accountRepository: accountRepository,
              projectRepository: projectRepository,
              preview: it)
          .dependencies();
    });
    isDefaultConfig = false;
  }

  @override
  String title() {
    final activityValue = activity.value;
    if (activityValue == null) {
      return WechatShareSource.defaults.getTitle();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : WechatShareSource.activity.getTitle(extraInfo: activityValue.name);
  }

  @override
  String description() {
    final activityValue = activity.value;
    if (activityValue == null) {
      return WechatShareSource.defaults.getDescription();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getDescription()
        : WechatShareSource.activity
            .getDescription(extraInfo: activityValue.summary);
  }

  @override
  String imageUrl() {
    final activityValue = activity.value;
    if (activityValue == null) {
      return WechatShareSource.defaults.getImageUrl();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getImageUrl()
        : WechatShareSource.activity.getImageUrl(
            extraInfo: activityValue.coverUrl,
          );
  }

  @override
  String link() {
    final activityValue = activity.value;
    if (activityValue == null) {
      return WechatShareSource.defaults.getImageUrl();
    }
    return isDefaultConfig
        ? WechatShareSource.defaults.getLink()
        : WechatShareSource.activity
            .getLink(extraInfo: '${ActivityParameter.id}=${activityValue.id}');
  }
}

class ActivityParameter {
  static const id = 'id';
}
