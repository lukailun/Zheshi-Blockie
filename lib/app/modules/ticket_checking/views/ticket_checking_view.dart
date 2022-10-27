// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/app/modules/ticket_checking/views/ticket_checking_item_view.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';

class TicketCheckingView extends GetView<TicketCheckingController> {
  const TicketCheckingView({super.key});

  @override
  Widget build(BuildContext context) {
    final infoView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('实名手机号：')
            .textColor(Colors.white)
            .fontSize(16)
            .paddingSymmetric(vertical: 8),
        const Divider(color: Color(0x1AFFFFFF), thickness: 1),
        Text('区块链地址：')
            .textColor(Colors.white)
            .fontSize(16)
            .paddingSymmetric(vertical: 8),
        const Divider(color: Color(0x1AFFFFFF), thickness: 1),
        Text('白名单状态：')
            .textColor(Colors.white)
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
      itemCount: 15,
      itemBuilder: (_, index) {
        return const TicketCheckingItemView();
      },
      separatorBuilder: (context, index) => const SizedBox(height: 22),
    );
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(title: '验票核销'),
      body: Column(
        children: [
          infoView,
          title,
          Expanded(child: items),
        ],
      ),
    );
  }
}
