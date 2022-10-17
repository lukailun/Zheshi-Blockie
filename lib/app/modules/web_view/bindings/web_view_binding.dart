// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';

class WebViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebViewController());
  }
}
