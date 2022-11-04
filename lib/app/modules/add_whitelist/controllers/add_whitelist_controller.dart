// Package imports:

// Dart imports:
import 'dart:js' as js;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/add_whitelist/models/add_whitelist_details.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';

class AddWhitelistController extends GetxController {
  final ProjectsManagementRepository repository;

  AddWhitelistController({required this.repository});

  final id = Get.parameters[AddWhitelistParameter.id] ?? '';

  final addWhitelistDetails = Rxn<AddWhitelistDetails>();
  final qrCode = Rxn<String>();

  final q =
      '{"data":{"user_uid":"Y8jy6jyWe9","timestamp":1667464059,"expired":1667467659},"signature":"97a60272450e933287a549686cf25739"}';

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

  void addWhitelist() async {}

  void scanQrCode() {
    addWhitelistDetails.value = null;
    qrCode.value = null;
    // wechatScanQrCode(
    //   WechatScanQrCodeParams(
    //     needResult: 1,
    //     scanType: 'qrCode',
    //     success: js.allowInterop(
    //       (result) {
    //         qrCode.value = result.resultStr;
    //         _getWhitelistStatus();
    //       },
    //     ),
    //   ),
    // );
    qrCode.value = q;
    _getWhitelistStatus();
  }

  void _getWhitelistStatus() async {
    addWhitelistDetails.value =
        await repository.getWhitelistStatus(id: id, qrCode: qrCode.value ?? '');
  }
}

class AddWhitelistParameter {
  static const id = 'id';
}
