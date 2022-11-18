import 'dart:async';

import 'package:blockie_app/services/wechat_service/wechat_service.dart';

abstract class WechatShareable {
  StreamSubscription<bool>? wechatReadyStream;

  bool _isDefaultConfig = true;

  bool get isDefaultConfig => _isDefaultConfig;

  set isDefaultConfig(bool newValue) {
    _isDefaultConfig = newValue;
    _updateShareConfig();
  }

  String title();

  String description();

  String link();

  String imageUrl();

  void _updateShareConfig() {
    if (WechatService.to.isReady.value) {
      WechatService.to.updateShareConfig(
        title: title(),
        description: description(),
        link: link(),
        imageUrl: imageUrl(),
      );
    } else {
      wechatReadyStream = WechatService.to.isReady.listen(
        (isReady) {
          if (isReady) {
            wechatReadyStream?.cancel();
            wechatReadyStream = null;
            WechatService.to.updateShareConfig(
              title: title(),
              description: description(),
              link: link(),
              imageUrl: imageUrl(),
            );
          }
        },
      );
    }
  }
}
