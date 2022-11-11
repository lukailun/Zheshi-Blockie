import 'package:get/get.dart';

class PreviewVideoController extends GetxController {
  final url = Get.parameters[PreviewVideoParameter.url] ?? '';
  final posterUrl = Get.parameters[PreviewVideoParameter.posterUrl] ?? '';
}

class PreviewVideoParameter {
  static const url = 'url';
  static const posterUrl = 'posterUrl';
}
