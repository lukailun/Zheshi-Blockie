import 'package:get/get.dart';

class PreviewVideoController extends GetxController {
  final url = Get.parameters[PreviewVideoParameter.url] ?? '';
  final posterUrl = Get.parameters[PreviewVideoParameter.posterUrl] ?? '';

  void back<T>({T? result}) {
    Get.back(result: result);
  }
}

class PreviewVideoParameter {
  static const url = 'url';
  static const posterUrl = 'posterUrl';
}
