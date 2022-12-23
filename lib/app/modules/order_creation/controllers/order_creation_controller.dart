import 'package:blockie_app/data/models/platform_info.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:get/get.dart';

part 'order_creation_controller_router.dart';

class OrderCreationController extends GetxController {
  final a = '1'.obs;

  @override
  void onReady() {
    super.onReady();
    MessageToast.showMessage('IsWx: ${PlatformInfo.isWechatBrowser}');
  }
}
