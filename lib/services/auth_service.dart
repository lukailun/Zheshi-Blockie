// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/models/user_info.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final _isLoggedIn = false.obs;
  final userInfo = Rxn<UserInfo>();

  bool get isLoggedIn => _isLoggedIn.value;

  void updateUserInfo(UserInfo? newUserInfo) {
    userInfo.value = newUserInfo;
  }

  void login() {
    _isLoggedIn.value = true;
  }

  void logout() {
    _isLoggedIn.value = false;
  }
}
