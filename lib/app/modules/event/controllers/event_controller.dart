// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/event/models/event.dart';
import 'package:blockie_app/app/modules/project_detail.dart';
import 'package:blockie_app/app/modules/registration_info/controllers/registration_info_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class EventController extends GetxController {
  final ProjectRepository repository;
  final event = Rxn<Event>();
  final showsLogin = false.obs;

  EventController({required this.repository});

  final _ID = Get.jsonParameters[EventParameter.ID] as String;

  @override
  void onInit() {
    super.onInit();
    _getEvent();
    _listenLogin();
  }

  void prepareToLogin() {
    showsLogin.value = true;
  }

  void goToRegistrationInfo(String eventID) async {
    final parameters = {
      RegistrationInfoParameter.ID: eventID,
    };
    await Get.toNamedWithJsonParameters(Routes.registrationInfo,
        parameters: parameters);
    _getEvent();
  }

  void goToProjectDetails(String ID) async {
    final parameters = {
      ProjectDetailsParameter.ID: ID,
      ProjectDetailsParameter.showsRule: true,
    };
    await Get.toNamedWithJsonParameters(Routes.projectDetails,
        parameters: parameters);
    _getEvent();
  }

  void _getEvent() async {
    event.value = await repository.getEvent(_ID);
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
      _getEvent();
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

class EventParameter {
  static const ID = "ID";
}
