// Dart imports:
import 'dart:async';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/utils/http_request.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  StreamSubscription<AnyWebEvent>? _loginStream;
  StreamSubscription<AnyWebEvent>? _logoutStream;

  final _isLoggedIn = false.obs;
  final userInfo = Rxn<UserInfo>();

  bool get isLoggedIn => _isLoggedIn.value;

  void login() {
    _isLoggedIn.value = true;
  }

  void logout() {
    _isLoggedIn.value = false;
  }

  void listenLogin({
    required Function() onLoginSuccess,
  }) {
    _loginStream = AnyWebService.to.accountsCode.listen((event) {
      if (event.isSuccessful) {
        _login(code: event.data as String, onLoginSuccess: onLoginSuccess);
      } else {
        _closeLoginDialog();
      }
    });
  }

  void listenLogout({
    required Function() onLogoutSuccess,
  }) {
    _logoutStream = AnyWebService.to.logout.listen((_) {
      _closeLogoutDialog();
      DataStorage.setToken('');
      logout();
      onLogoutSuccess();
    });
  }

  void _closeLoginDialog() {
    Get.back();
    _loginStream?.cancel();
    _loginStream = null;
  }

  void _closeLogoutDialog() {
    Get.back();
    _logoutStream?.cancel();
    _logoutStream = null;
  }

  void _login({
    required String code,
    required Function() onLoginSuccess,
  }) async {
    try {
      Map<String, dynamic> res = await HttpRequest.login(code);
      String token = res['token'];
      UserInfo user = res['user'];
      DataStorage.setToken(token);
      DataStorage.setUserUid(user.uid);
      userInfo.value = user;
      login();
      _closeLoginDialog();
      onLoginSuccess();
    } catch (e) {
      _closeLoginDialog();
      if (DataStorage.getToken() != null) {
        UserInfo user = await HttpRequest.getUserInfo(DataStorage.getToken()!);
        userInfo.value = user;
        login();
      }
    }
  }
}
