// Dart imports:
import 'dart:html' as html;
import 'dart:js' as js;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/apis/blockie_api.dart';
import 'package:blockie_app/data/apis/models/wechat_config.dart';
import 'package:blockie_app/data/apis/models/wechat_share_source.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';
import 'package:blockie_app/utils/data_storage.dart';

class WechatService extends GetxService {
  static WechatService get to => Get.find();

  WechatConfig? _config;

  final _repository = AccountRepository(
    remoteApi: BlockieApi(
      userTokenSupplier: () => DataStorage.getToken(),
    ),
  );

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
    _config ??= await _repository.getWechatConfig(link, wechatSupportedApis);
    if (_config == null) {
      return;
    }
    final config = _config!;
    wechatConfig(
      WechatConfigParams(
        debug: config.isDebug,
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
