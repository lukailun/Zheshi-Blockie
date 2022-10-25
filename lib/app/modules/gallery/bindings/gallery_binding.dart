// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/gallery/controllers/gallery_controller.dart';

class GalleryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryController());
  }
}
