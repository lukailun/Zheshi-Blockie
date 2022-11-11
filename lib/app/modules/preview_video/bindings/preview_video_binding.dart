import 'package:get/get.dart';
import 'package:blockie_app/app/modules/preview_video/controllers/preview_video_controller.dart';

class PreviewVideoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreviewVideoController());
  }
}
