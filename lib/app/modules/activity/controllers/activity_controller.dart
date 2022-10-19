// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/activity.dart';
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/app/modules/registration_info/controllers/registration_info_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/models/wechat_share_source.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';

class ActivityController extends GetxController {
  final ProjectRepository repository;
  final activity = Rxn<Activity>();
  final showsLogin = false.obs;

  ActivityController({required this.repository});

  final _id = Get.parameters[ActivityParameter.id] as String;

  @override
  void onReady() {
    super.onReady();
    _getActivity();
    _listenLogin();
  }

  @override
  void onClose() {
    super.onClose();
    _updateShareConfig(isDefaultConfig: true);
  }

  void prepareToLogin() {
    showsLogin.value = true;
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
    activity.value = await repository.getActivity(_id);
    _updateShareConfig(isDefaultConfig: false);
  }

  void _updateShareConfig({required bool isDefaultConfig}) {
    if (activity.value == null) return;
    final activityValue = activity.value!;
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

  void _listenLogin() async {
    AnyWebService.to.accountsCode.listen((event) {
      if (event.isSuccessful) {
        _login(event.data as String);
      } else {
        showsLogin.value = false;
      }
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
      showsLogin.value = false;
      _getActivity();
    } catch (e) {
      if (DataStorage.getToken() != null) {
        UserInfo userInfo =
            await HttpRequest.getUserInfo(DataStorage.getToken()!);
        AuthService.to.updateUserInfo(userInfo);
        showsLogin.value = false;
      }
    }
  }
}

class ActivityParameter {
  static const id = "id";
}
