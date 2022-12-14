// Dart imports:
import 'dart:js' as js;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/airdrop_nft/models/airdrop_nft_details.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';

part 'airdrop_nft_controller_router.dart';

class AirdropNftController extends GetxController {
  final ProjectsManagementRepository repository;

  AirdropNftController({required this.repository});

  final id = Get.parameters[AirdropNftParameter.id] ?? '';

  final airdropNftDetails = Rxn<AirdropNftDetails>();
  final qrCode = Rxn<String>();

  @override
  void onReady() {
    super.onReady();
    scanQrCode();
  }

  bool airdropNftButtonIsEnabled() {
    final airdropNftDetailsValue = airdropNftDetails.value;
    if (airdropNftDetailsValue == null) {
      return false;
    }
    if (!airdropNftDetailsValue.user.isQualified) {
      return false;
    }
    return airdropNftDetailsValue.activity.isSelected;
  }

  void airdropNft() async {
    final airdropNftDetailsValue = airdropNftDetails.value;
    if (airdropNftDetailsValue == null) {
      return;
    }
    airdropNftDetails.value =
        await repository.airdropNfts(id: id, qrCode: qrCode.value ?? '');
  }

  void scanQrCode() {
    airdropNftDetails.value = null;
    qrCode.value = null;
    wechatScanQrCode(
      WechatScanQrCodeParams(
        needResult: 1,
        scanType: 'qrCode',
        success: js.allowInterop(
          (result) {
            qrCode.value = result.resultStr;
            getAirdropNfts();
          },
        ),
      ),
    );
  }

  void getAirdropNfts() async {
    airdropNftDetails.value =
        await repository.getAirdropNfts(id: id, qrCode: qrCode.value ?? '');
  }
}

class AirdropNftParameter {
  static const id = 'id';
}
