// Dart imports:
import 'dart:js' as js;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/hold_verification/models/hold_verification_details.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';

part 'hold_verification_controller_router.dart';

class HoldVerificationController extends GetxController {
  final ProjectsManagementRepository repository;

  HoldVerificationController({required this.repository});

  final id = Get.parameters[HoldVerificationParameter.id] ?? '';

  final holdVerificationDetails = Rxn<HoldVerificationDetails>();
  final qrCode = Rxn<String>();

  @override
  void onReady() {
    super.onReady();
    scanQrCode();
  }

  void scanQrCode() {
    holdVerificationDetails.value = null;
    qrCode.value = null;
    wechatScanQrCode(
      WechatScanQrCodeParams(
        needResult: 1,
        scanType: 'qrCode',
        success: js.allowInterop(
          (result) {
            qrCode.value = result.resultStr;
            getHoldVerificationDetails();
          },
        ),
      ),
    );
  }

  void getHoldVerificationDetails() async {
    holdVerificationDetails.value = await repository.getHoldVerificationDetails(
        id: id, qrCode: qrCode.value ?? '');
  }
}

class HoldVerificationParameter {
  static const id = 'id';
}
