// Dart imports:
import 'dart:html' as html;
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

class PlatformInfo {
  static bool? _isApple;
  static bool? _isAndroid;
  static bool? _isIOS;
  static bool? _isMacOS;
  static bool? _isWindows;
  static bool? _isLinux;

  static bool get isApple => _isApple ?? _getIsApple();

  static bool get isAndroid => _isAndroid ?? _getIsAndroid();

  static bool get isIOS => _isIOS ?? _getIsIOS();

  static bool get isMacOS => _isMacOS ?? _getIsMacOS();

  static bool get isWindows => _isWindows ?? _getIsWindows();

  static bool get isLinux => _isLinux ?? _getIsLinux();

  static bool get isWeb => kIsWeb;

  static bool get isWechatBrowser {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('micromessenger');
  }

  static void _getPlatforms() {
    if (kIsWeb) {
      _getWebPlatforms();
    } else {
      _isApple = Platform.isIOS || Platform.isMacOS;
      _isAndroid = Platform.isAndroid;
      _isIOS = Platform.isIOS;
      _isMacOS = Platform.isMacOS;
      _isWindows = Platform.isWindows;
      _isLinux = Platform.isLinux;
    }
  }

  static void _getWebPlatforms() {
    final platforms = {
      "iPad Simulator": "I",
      "iPhone Simulator": "I",
      "iPod Simulator": "I",
      "iPad": "I",
      "iPhone": "I",
      "iPod": "I",
      "Linux": "L",
      "X11": "L",
      "like Mac": "I",
      "Mac": "M",
      "Win": "W",
      "Android": "A",
    };

    var platform = "A";

    for (final name in platforms.keys) {
      if ((html.window.navigator.platform?.contains(name) ?? false) ||
          html.window.navigator.userAgent.contains(name)) {
        platform = platforms[name] ?? 'A';
        break;
      }
    }

    _isApple = platform == "I" || platform == "M";
    _isAndroid = platform == "A";
    _isIOS = platform == "I";
    _isMacOS = platform == "M";
    _isWindows = platform == "W";
    _isLinux = platform == "L";
  }

  static bool _getIsApple() {
    _getPlatforms();
    return _isApple ?? false;
  }

  static bool _getIsAndroid() {
    _getPlatforms();
    return _isAndroid ?? false;
  }

  static bool _getIsIOS() {
    _getPlatforms();
    return _isIOS ?? false;
  }

  static bool _getIsMacOS() {
    _getPlatforms();
    return _isMacOS ?? false;
  }

  static bool _getIsWindows() {
    _getPlatforms();
    return _isWindows ?? false;
  }

  static bool _getIsLinux() {
    _getPlatforms();
    return _isLinux ?? false;
  }
}
