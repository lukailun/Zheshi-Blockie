// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/souvenir.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/ticket_checking_details.dart';
import 'package:blockie_app/app/modules/ticket_checking/views/ticket_checking_item_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/projects_management_footer_view.dart';
import 'package:blockie_app/widgets/projects_management_user_view.dart';

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
              ProjectsManagementFooterView(
                topButtonTitle: '核销所选 NFT 权益',
                bottomButtonTitle: '继续扫码',
                topButtonIsEnabled: controller.ticketCheckingButtonIsEnabled(),
                topButtonOnTap: controller.checkTicket,
                bottomButtonOnTap: controller.scanQrCode,
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
    final userView =
        ProjectsManagementUserView(user: ticketCheckingDetails.user);
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
        userView,
        title,
        Expanded(child: items),
      ],
    );
  }
}
