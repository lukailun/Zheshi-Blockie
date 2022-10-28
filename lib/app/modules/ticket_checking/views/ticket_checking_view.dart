// Flutter imports:
import 'package:blockie_app/app/modules/ticket_checking/models/souvenir.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/ticket_checking_details.dart';
import 'package:blockie_app/app/modules/ticket_checking/views/ticket_checking_footer_view.dart';
import 'package:blockie_app/widgets/ellipsized_text.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/app/modules/ticket_checking/views/ticket_checking_item_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';

class TicketCheckingContainerView extends GetView<TicketCheckingController> {
  const TicketCheckingContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '验票核销'),
        body: () {
          final ticketCheckingDetailsValue =
              controller.ticketCheckingDetails.value;
          return Stack(
            children: [
              () {
                if (ticketCheckingDetailsValue == null) {
                  return const SizedBox();
                } else {
                  return _TicketCheckingView(
                    ticketCheckingDetails: ticketCheckingDetailsValue,
                    souvenirOnTap: (projectIndex, souvenirIndex, souvenir) {
                      final souvenir = ticketCheckingDetailsValue
                          .nfts[projectIndex].souvenirs[souvenirIndex];
                      ticketCheckingDetailsValue
                              .nfts[projectIndex].souvenirs[souvenirIndex] =
                          souvenir..isSelected = !souvenir.isSelected;
                      controller.ticketCheckingDetails.value = null;
                      controller.ticketCheckingDetails.value =
                          ticketCheckingDetailsValue;
                    },
                  ).paddingOnly(bottom: 182);
                }
              }(),
              Container(
                alignment: Alignment.bottomCenter,
                child: TicketCheckingFooterView(
                  checkTicketIsEnabled: () {
                    if (ticketCheckingDetailsValue == null) {
                      return false;
                    }
                    if (!ticketCheckingDetailsValue.user.isQualified) {
                      return false;
                    }
                    final allSouvenirs = ticketCheckingDetailsValue.nfts
                        .expand((it) => it.souvenirs)
                        .toList();
                    final hasSelected =
                        allSouvenirs.where((it) => it.isSelected).isNotEmpty;
                    return hasSelected;
                  }(),
                  checkTicketOnTap: controller.checkTicket,
                  scanOnTap: controller.scanQrCode,
                ),
              ),
            ],
          );
        }(),
      ),
    );
  }
}

class _TicketCheckingView extends StatelessWidget {
  final TicketCheckingDetails ticketCheckingDetails;
  final Function(int, int, Souvenir) souvenirOnTap;

  const _TicketCheckingView({
    required this.ticketCheckingDetails,
    required this.souvenirOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final infoView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('实名手机号：${_displayPhoneNumber(ticketCheckingDetails.user.phoneNumber ?? '')}')
            .textColor(Colors.white)
            .fontSize(16)
            .paddingSymmetric(vertical: 8),
        const Divider(color: Color(0x1AFFFFFF), thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('区块链地址：')
                .textColor(Colors.white)
                .fontSize(16)
                .paddingSymmetric(vertical: 8),
            SizedBox(
              width: 160,
              child: EllipsizedText(
                ticketCheckingDetails.user.wallet.first.address,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                ellipsis: Ellipsis.middle,
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
        const Divider(color: Color(0x1AFFFFFF), thickness: 1),
        Text('白名单状态：${ticketCheckingDetails.user.isQualified ? '已在白名单' : '未在白名单'}')
            .textColor(ticketCheckingDetails.user.isQualified
                ? Colors.white
                : const Color(0xFFFF8F1F))
            .fontSize(16)
            .paddingSymmetric(vertical: 8),
        const Divider(color: Color(0x1AFFFFFF), thickness: 1),
      ],
    ).paddingSymmetric(horizontal: 59, vertical: 23);
    final title = SizedBox(
      width: double.infinity,
      child: const Text('选择 NFT 权益').textColor(Colors.white).fontSize(18),
    ).paddingOnly(left: 22, right: 22, bottom: 22);
    final items = ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      itemCount: ticketCheckingDetails.nfts.length,
      itemBuilder: (_, index) {
        return TicketCheckingItemView(
          nft: ticketCheckingDetails.nfts[index],
          souvenirOnTap: (souvenirIndex, souvenir) =>
              souvenirOnTap(index, souvenirIndex, souvenir),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 22),
    );
    return Column(
      children: [
        infoView,
        title,
        Expanded(child: items),
      ],
    );
  }

  String _displayPhoneNumber(String phone) {
    if (phone.length != 11) {
      return phone;
    }
    return "${phone.substring(0, 3)}****${phone.substring(phone.length - 4)}";
  }
}
