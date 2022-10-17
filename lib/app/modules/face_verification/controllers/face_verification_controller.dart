// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import '../../web_view/controllers/web_view_controller.dart';

class FaceVerificationController extends GetxController {
  final AccountRepository repository;

  FaceVerificationController({required this.repository});

  void uploadFacePhoto(List<int> bytes, String filename) async {
    final faceInfo = await repository.uploadFacePhoto(bytes, filename);
    if (faceInfo != null) {
      MessageToast.showMessage("上传成功");
      Get.back(result: true);
    } else {
      MessageToast.showMessage("上传失败");
    }
  }

  void goToTermsOfService() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildTermsOfServiceUrl(),
    };
    Get.toNamedWithJsonParameters(Routes.webView, parameters: parameters);
  }

  void goToPrivacyPolicy() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildPrivacyPolicyUrl(),
    };
    Get.toNamedWithJsonParameters(Routes.webView, parameters: parameters);
  }
}
