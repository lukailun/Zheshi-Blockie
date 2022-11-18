// Package imports:
import 'package:dio_log/http_log_list_widget.dart';
import 'package:get/get.dart';

class DeveloperModeController extends GetxController {
  void goToHttpLog() {
    Get.to(HttpLogListWidget());
  }
}
