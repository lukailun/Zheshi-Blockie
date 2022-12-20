// Package imports:

// Dart imports:
import 'dart:js' as js;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/add_whitelist/models/add_whitelist_details.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';

part 'add_whitelist_controller_router.dart';

class AddWhitelistController extends GetxController {
  final ProjectsManagementRepository repository;

  AddWhitelistController({required this.repository});

  final id = Get.parameters[AddWhitelistParameter.id] ?? '';

  final addWhitelistDetails = Rxn<AddWhitelistDetails>();
  final qrCode = Rxn<String>();

  @override
  void onReady() {
    super.onReady();
    scanQrCode();
  }

  bool addWhitelistButtonIsEnabled() {
    final addWhitelistDetailsValue = addWhitelistDetails.value;
    if (addWhitelistDetailsValue == null) {
      return false;
    }
    return !addWhitelistDetailsValue.user.isQualified;
  }

  void addWhitelist() async {
    addWhitelistDetails.value =
        await repository.addWhitelist(id: id, qrCode: qrCode.value ?? '');
  }

  void scanQrCode() {
    addWhitelistDetails.value = null;
    qrCode.value = null;
    wechatScanQrCode(
      WechatScanQrCodeParams(
        needResult: 1,
        scanType: 'qrCode',
        success: js.allowInterop(
          (result) {
            qrCode.value = result.resultStr;
            getWhitelistStatus();
          },
        ),
      ),
    );
  }

  void getWhitelistStatus() async {
    addWhitelistDetails.value =
        await repository.getWhitelistStatus(id: id, qrCode: qrCode.value ?? '');
  }
}

class AddWhitelistParameter {
  static const id = 'id';
}
