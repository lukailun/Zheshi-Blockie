import 'dart:html';

const String tokenName = "token";

class DataStorage{
  static void _setStorageValue(String valueName, String value) {
    window.localStorage[valueName] = value;
  }
  
  static String? _getStorageValue(String valueName) {
    return window.localStorage.containsKey(valueName) ? window.localStorage[valueName] : null;
  }
  
  static void setToken(String token) {
    DataStorage._setStorageValue(tokenName, token);
  }
  
  static String? getToken() {
    return DataStorage._getStorageValue(tokenName);
  }
}
