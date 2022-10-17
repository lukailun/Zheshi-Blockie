// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

class WebViewController extends GetxController {
  final String url = Get.jsonParameters[WebViewParameter.url];
}

class WebViewParameter {
  static const url = "url";
}
