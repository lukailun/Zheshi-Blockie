import 'package:get/get.dart';

class AppRouter {
  static Future<T?>? toNamed<T>(String page,
      {Map<String, String>? parameters}) {
    return Get.toNamed(page, parameters: parameters);
  }

  static Future<T?>? to<T>(dynamic page) {
    return Get.to(page);
  }

  static void back<T>({T? result}) {
    Get.back();
  }
}
