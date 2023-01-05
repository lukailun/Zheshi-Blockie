import 'package:blockie_app/app/modules/apply_for_refund/controllers/apply_for_refund_controller.dart';
import 'package:blockie_app/widgets/order_description.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_text_field.dart';

class ApplyForRefundView extends GetView<ApplyForRefundController> {
  const ApplyForRefundView({super.key});

  @override
  Widget build(BuildContext context) {
    final reason = const Text('退款原因').textColor(Colors.white).fontSize(14);
    final textField = SizedBox(
      width: double.infinity,
      child: Center(
        child: BasicTextField(
          autofocus: true,
          maxLines: 10,
          text: controller.refundReason.value,
          onValueChanged: (text) => controller.refundReason.value = text,
        ).paddingSymmetric(horizontal: 18),
      ),
    ).outlined().paddingOnly(top: 13, bottom: 21);
    final submitButton = SizedBox(
      height: 48,
      child: BasicElevatedButton(
        title: '提交',
        // isEnabled: controller.refundReason.isNotEmpty,
        borderRadius: 8,
        backgroundColor: Colors.white,
        textColor: AppThemeData.primaryColor,
        textFontSize: 18,
        onTap: () {},
      ),
    ).paddingSymmetric(vertical: 36);
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(title: '退款申请'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppThemeData.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reason,
            textField,
            const OrderDescription(descriptions: ['退款申请成功后我们将原路退回你所支付的金额。']),
            const Spacer(flex: 1),
            submitButton,
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
