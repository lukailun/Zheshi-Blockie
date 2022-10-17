// Dart imports:
import 'dart:html' as html;
import 'dart:js' as js;

// Package imports:
import 'package:blockie_app/services/wechat_service/wechat_share_source.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/apis/blockie_api.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';
import 'package:blockie_app/utils/data_storage.dart';

class WechatService extends GetxService {
  static WechatService get to => Get.find();

  final _url = html.window.location.href.split("#").first;
  final _repository = AccountRepository(
    remoteAPI: BlockieAPI(
      userTokenSupplier: () => DataStorage.getToken(),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    _getWechatConfig();
  }

  void updateShareInfo({
    required String title,
    required String description,
    required String imageUrl,
  }) {
    wechatUpdateAppMessageShareData(
      WechatUpdateAppMessageShareDataParams(
        title: title,
        desc: description,
        imgUrl: imageUrl,
      ),
    );
    wechatUpdateTimelineShareData(
      WechatUpdateTimelineShareDataParams(
        title: title,
        imgUrl: imageUrl,
      ),
    );
  }

  void _getWechatConfig() async {
    final config = await _repository.getWechatConfig(_url, wechatSupportedAPIs);
    if (config == null) {
      return;
    }
    wechatConfig(
      WechatConfigParams(
        debug: config.isDebug,
        appId: config.appID,
        timestamp: config.timestamp,
        nonceStr: config.nonceString,
        signature: config.signature,
        jsApiList: wechatSupportedAPIs,
      ),
    );
    wechatReady(js.allowInterop(() {
      wechatUpdateAppMessageShareData(WechatUpdateAppMessageShareDataParams(
          title: "Blockie",
          desc: "Hello world",
          link: html.window.location.href,
          imgUrl:
              "https://www.gravatar.com/avatar/1be49f9ea6f801adf0681747955c1cde?s=256&d=identicon&r=PG",
          success: () {
            alert("UpdateAppMessageSuccess");
          }));
    }));

    wechatError(js.allowInterop((error) {
      alert("Error: $error");
    }));
  }

// void _getWechatConfig() async {
//   final config = await _repository.getWechatConfig(_url, wechatSupportedAPIs);
//   if (config == null) {
//     return;
//   }
//   wechatConfig(
//     WechatConfigParams(
//       debug: config.isDebug,
//       appId: config.appID,
//       timestamp: config.timestamp,
//       nonceStr: config.nonceString,
//       signature: config.signature,
//       jsApiList: wechatSupportedAPIs,
//     ),
//   );
//
//   wechatReady(
//     js.allowInterop(
//       () {
//         final title = WechatShareSource.defaults.getTitle();
//         final description = WechatShareSource.defaults.getDescription();
//         final imageUrl = WechatShareSource.defaults.getImageUrl();
//         updateShareInfo(
//           title: title,
//           description: description,
//           imageUrl: imageUrl,
//         );
//       },
//     ),
//   );
// }
}
