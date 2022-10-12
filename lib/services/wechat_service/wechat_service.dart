import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'dart:js' as js;

class WechatService extends GetxService {
  static WechatService get to => Get.find();

  final _url = html.window.location.href.split("#").first;
  final _repository = AccountRepository(client: HttpRequest());

  @override
  void onInit() {
    super.onInit();
    _getWechatConfig();
  }

  void _getWechatConfig() async {
    final config = await _repository.getWechatConfig(_url, wechatSupportedAPIs);
    wechatConfig(
      WechatConfigParams(
        debug: config.isDebug,
        appId: config.appID,
        timestamp: config.timestamp,
        nonceStr: config.nonce,
        signature: config.signature,
        jsApiList: wechatSupportedAPIs,
      ),
    );
    const shareDataTitle = "Blockie";
    const shareDataDesc = "blockie";
    const shareDataImgUrl =
        "https://www.gravatar.com/avatar/1be49f9ea6f801adf0681747955c1cde?s=256&d=identicon&r=PG";
    wechatReady(
      js.allowInterop(
        () {
          wechatUpdateAppMessageShareData(
            WechatUpdateAppMessageShareDataParams(
              title: shareDataTitle,
              desc: shareDataDesc,
              link: html.window.location.href,
              imgUrl: shareDataImgUrl,
            ),
          );
          wechatUpdateTimelineShareData(
            WechatUpdateTimelineShareDataParams(
              title: shareDataTitle,
              link: html.window.location.href,
              imgUrl: shareDataImgUrl,
            ),
          );
        },
      ),
    );
  }
}
