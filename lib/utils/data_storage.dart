// Dart imports:
import 'dart:html';

const String tokenName = "token";
const String userUidName = "user_uid";

class DataStorage {
  static void _setStorageValue(String valueName, String value) {
    window.localStorage[valueName] = value;
  }

  static String? _getStorageValue(String valueName) {
    return window.localStorage.containsKey(valueName)
        ? window.localStorage[valueName]
        : null;
  }

  static void setToken(String token) {
    DataStorage._setStorageValue(tokenName, token);
  }

  static String? getToken() {
    return DataStorage._getStorageValue(tokenName);
  }

  static void setUserUid(String uid) {
    DataStorage._setStorageValue(userUidName, uid);
  }

  static String? getUserUid() {
    return DataStorage._getStorageValue(userUidName);
  }
}
