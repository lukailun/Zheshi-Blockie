// Package imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/extensions/get_dialog_extension.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/activity.dart';
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/app/modules/registration_info/controllers/registration_info_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/models/wechat_share_source.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_service.dart';

class ActivityController extends GetxController {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;
  final activity = Rxn<Activity>();
  final showsLogin = false.obs;

  ActivityController({
    required this.accountRepository,
    required this.projectRepository,
  });

  final _id = Get.parameters[ActivityParameter.id] as String;

  @override
  void onReady() {
    super.onReady();
    _getActivity();
  }

  @override
  void onClose() {
    super.onClose();
    _updateShareConfig(isDefaultConfig: true);
  }

  void showLicenseDialog() {
    Get.licenseDialog(onLoginSuccess: () {
      MessageToast.showMessage("登录成功");
      getUser();
    });
  }

  void getUser() async {
    if ((DataStorage.getToken() ?? '').isNotEmpty) {
      final user = await accountRepository.getUser();
      AuthService.to.user.value = user;
      AuthService.to.login();
    } else {
      AuthService.to.user.value = null;
      AuthService.to.logout();
    }
  }

  void goToRegistrationInfo(String activityId) async {
    final parameters = {
      RegistrationInfoParameter.id: activityId,
    };
    await Get.toNamed(Routes.registrationInfo, parameters: parameters);
    _getActivity();
  }

  void goToProjectDetails(String id) async {
    final parameters = {
      ProjectDetailsParameter.id: id,
      ProjectDetailsParameter.showsRule: "true",
    };
    await Get.toNamed(Routes.projectDetails, parameters: parameters);
    _getActivity();
  }

  void goToBrand(String id) async {
    final parameters = {
      'issuerUid': id,
    };
    await Get.toNamed(Routes.brand, parameters: parameters);
    _getActivity();
  }

  void _getActivity() async {
    activity.value = await projectRepository.getActivity(_id);
    _updateShareConfig(isDefaultConfig: false);
  }

  void _updateShareConfig({required bool isDefaultConfig}) {
    final activityValue = activity.value;
    if (activityValue == null) {
      return;
    }
    final title = isDefaultConfig
        ? WechatShareSource.defaults.getTitle()
        : WechatShareSource.activity.getTitle(extraInfo: activityValue.name);
    final description = isDefaultConfig
        ? WechatShareSource.defaults.getDescription()
        : WechatShareSource.activity
            .getDescription(extraInfo: activityValue.summary);
    final link = isDefaultConfig
        ? WechatShareSource.defaults.getLink()
        : WechatShareSource.activity.getLink();
    final imageUrl = isDefaultConfig
        ? WechatShareSource.defaults.getImageUrl()
        : WechatShareSource.activity.getImageUrl(
            extraInfo: activityValue.steps
                .firstWhere((it) => (it.imagePath ?? '').isNotEmpty)
                .imageUrl,
          );
    WechatService.to.updateShareConfig(
      title: title,
      description: description,
      link: link,
      imageUrl: imageUrl,
    );
  }
}

class ActivityParameter {
  static const id = "id";
}
