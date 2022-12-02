// Dart imports:
import 'dart:html' as html;
import 'dart:js' as js;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/models/wechat_config.dart';
import 'package:blockie_app/data/models/wechat_share_source.dart';
import 'package:blockie_app/data/repositories/common_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';

class WechatService extends GetxService {
  static WechatService get to => Get.find();

  WechatConfig? _config;
  final isReady = false.obs;

  final CommonRepository commonRepository;

  WechatService({required this.commonRepository});

  @override
  void onReady() {
    super.onReady();
    _setupShareConfig();
  }

  void updateShareConfig({
    required String title,
    required String description,
    required String link,
    required String imageUrl,
  }) {
    wechatUpdateAppMessageShareData(
      WechatUpdateAppMessageShareDataParams(
        title: title,
        desc: description,
        link: link,
        imgUrl: imageUrl,
      ),
    );
    wechatUpdateTimelineShareData(
      WechatUpdateTimelineShareDataParams(
        title: title,
        link: link,
        imgUrl: imageUrl,
      ),
    );
  }

  void _setupShareConfig() async {
    final title = WechatShareSource.defaults.getTitle();
    final description = WechatShareSource.defaults.getDescription();
    final link = html.window.location.href.split("#").first;
    final imageUrl = WechatShareSource.defaults.getImageUrl();
    _config ??=
        await commonRepository.getWechatConfig(link, wechatSupportedApis);
    if (_config == null) {
      return;
    }
    final config = _config!;
    wechatConfig(
      WechatConfigParams(
        debug: false,
        appId: config.appId,
        timestamp: config.timestamp,
        nonceStr: config.nonceString,
        signature: config.signature,
        jsApiList: wechatSupportedApis,
      ),
    );
    wechatReady(
      js.allowInterop(
        () {
          isReady.value = true;
          final route = html.window.location.href.split('#').last;
          if (route != Routes.activities) {
            return;
          }
          updateShareConfig(
            title: title,
            description: description,
            link: link,
            imageUrl: imageUrl,
          );
        },
      ),
    );
  }
}
