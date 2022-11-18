// Package imports:
import 'package:get/get.dart';

class DebugService extends GetxService {
  static DebugService get to => Get.find();
  final showsFps = true.obs;
  final isDevTitle = true.obs;
}
