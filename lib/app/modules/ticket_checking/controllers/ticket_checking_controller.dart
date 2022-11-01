// Dart imports:
import 'dart:js' as js;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/models/ticket_checking_details.dart';
import 'package:blockie_app/data/repositories/project_management_repository.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';

class TicketCheckingController extends GetxController {
  final ProjectManagementRepository repository;

  TicketCheckingController({required this.repository});

  final id = Get.parameters[TicketCheckingParameter.id] ?? '';

  final ticketCheckingDetails = Rxn<TicketCheckingDetails>();
  final qrCode = Rxn<String>();

  @override
  void onReady() {
    super.onReady();
    scanQrCode();
  }

  void checkTicket() async {
    final List<Map<String, String>> souvenirsMapList = [];
    final ticketCheckingDetailsValue = ticketCheckingDetails.value;
    if (ticketCheckingDetailsValue == null) {
      return;
    }
    ticketCheckingDetailsValue.nfts.forEach((nft) {
      nft.souvenirs.forEach((souvenir) {
        if (souvenir.isSelected) {
          souvenirsMapList.add(
            {
              'souvenir_uid': souvenir.id,
              'nft_uid': nft.id,
            },
          );
        }
      });
    });
    ticketCheckingDetails.value = await repository.checkTickets(
        souvenirsMapList: souvenirsMapList, qrCode: qrCode.value ?? '');
  }

  void scanQrCode() {
    ticketCheckingDetails.value = null;
    qrCode.value = null;
    wechatScanQrCode(
      WechatScanQrCodeParams(
        needResult: 1,
        scanType: 'qrCode',
        success: js.allowInterop(
          (result) {
            qrCode.value = result.resultStr;
            _getManagedProjectNfts();
          },
        ),
      ),
    );
  }

  void _getManagedProjectNfts() async {
    ticketCheckingDetails.value = await repository.getManagedProjectNfts(
        id: id, qrCode: qrCode.value ?? '');
  }
}

class TicketCheckingParameter {
  static const id = 'id';
}
