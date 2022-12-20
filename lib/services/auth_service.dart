// Dart imports:
import 'dart:async';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/user_info.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/utils/data_storage.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final AccountRepository accountRepository;

  AuthService({required this.accountRepository});

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

  void updateUserInfo({Function()? callback}) async {
    if ((DataStorage.getToken() ?? '').isNotEmpty) {
      userInfo.value = await accountRepository.getUserInfo();
      callback?.call();
    }
  }

  void _login({
    required String code,
    required Function() onLoginSuccess,
  }) async {
    try {
      final tokenInfo = await accountRepository.login(code);
      if (tokenInfo == null) {
        return;
      }
      DataStorage.setToken(tokenInfo.token);
      final newUserInfo = await accountRepository.getUserInfo();
      if (newUserInfo == null) {
        return;
      }
      DataStorage.setUserUid(newUserInfo.id);
      userInfo.value = newUserInfo;
      login();
      _closeLoginDialog();
      onLoginSuccess();
    } catch (error) {
      _closeLoginDialog();
      if ((DataStorage.getToken() ?? '').isNotEmpty) {
        userInfo.value = await accountRepository.getUserInfo();
        login();
      }
    }
  }
}
