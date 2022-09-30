import 'package:blockie_app/app/modules/event/models/event.dart';
import 'package:blockie_app/app/modules/registration_info/controllers/registration_info_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:get/get.dart';
import 'package:blockie_app/utils/http_request.dart';

class EventController extends GetxController {
  final ProjectRepository repository;
  final event = Rxn<Event>();
  final showsLogin = false.obs;

  EventController({required this.repository});

  final _ID = Get.parameters[EventParameter.ID] ?? "";

  @override
  void onInit() {
    super.onInit();
    _getEvent();
    _listenLogin();
  }

  void prepareToLogin() {
    showsLogin.value = true;
  }

  void goToRegistrationInfo() {
    Get.toNamed(
        "${Routes.registrationInfo}?${RegistrationInfoParameter.ID}=${event.value?.steps[2].ID ?? ""}");
  }

  void goToProjectDetails(String ID) {
    Get.toNamed("${Routes.projectDetails}?projectUid=$ID&showsRule=${true}");
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
