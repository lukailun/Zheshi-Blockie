import 'package:blockie_app/common/user_info.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final _isLoggedIn = false.obs;
  final userInfo = Rxn<UserInfo>();

  bool get isLoggedIn => _isLoggedIn.value;

  // UserInfo? get userInfo => _userInfo.value;

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
