// Package imports:
import 'package:get/get.dart';

class WebViewController extends GetxController {
  final url = Get.parameters[WebViewParameter.url] ?? '';
}

class WebViewParameter {
  static const url = 'url';
}
