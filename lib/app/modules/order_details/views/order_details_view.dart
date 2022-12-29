import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/order_description.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/order_details/controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '订单详情'),
        body: () {
          // final orders = controller.orders.value;
          final orders = [controller.a.value, 'b', 'c', 'd', 'dd', 'd'];
          if (orders == null) {
            return const LoadingIndicator();
          }
          final title = Text('2022上海市篮球冠军联赛')
              .textColor(Colors.white)
              .fontSize(26)
              .fontWeight(FontWeightCompat.bold)
              .paddingSymmetric(horizontal: 22);
          final location = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: true,
                child: Image.asset(
                  'assets/images/activities/location.png',
                  width: 10,
                  height: 12,
                  fit: BoxFit.contain,
                ).paddingOnly(right: 4),
              ),
              Flexible(
                child: Text(
                  '上海·徐汇XXX篮球场',
                  overflow: TextOverflow.ellipsis,
                )
                    .fontSize(10)
                    .textColor(const Color(0x80FFFFFF))
                    .paddingOnly(right: 4),
              ),
            ],
          ).paddingOnly(left: 22, right: 22, top: 15);
          final time = Text(
            '9月30日 周六 18:00',
            overflow: TextOverflow.ellipsis,
          )
              .fontSize(10)
              .textColor(const Color(0x80FFFFFF))
              .paddingSymmetric(horizontal: 22, vertical: 4);
          final test = ['3V3 女子赛报名门票', '纪念飞盘'];
          final goods = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: test.map((it) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(it)
                          .fontSize(14)
                          .fontWeight(FontWeightCompat.mostThick)
                          .textColor(Colors.white),
                      Expanded(
                        child: Text('× 1')
                            .fontSize(14)
                            .fontWeight(FontWeightCompat.bold)
                            .textColor(const Color(0x99FFFFFF))
                            .paddingSymmetric(horizontal: 5),
                      ),
                      Text('¥ 220')
                          .fontSize(14)
                          .fontWeight(FontWeightCompat.bold)
                          .textColor(Colors.white),
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 22, vertical: 6);
            }).toList(),
          ).paddingSymmetric(vertical: 6);
          final divider = Container(
            height: 2,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x4DFFFFFF),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(-2, 1),
                ),
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(-1, -1),
                ),
              ],
            ),
          );
          final totalAmount = SizedBox(
            width: double.infinity,
            child: Text('已支付：¥ 220')
                .fontSize(14)
                .textAlignment(TextAlign.right)
                .fontWeight(FontWeightCompat.mostThick)
                .textColor(Colors.white),
          ).paddingSymmetric(horizontal: 22, vertical: 6);
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 143),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                location,
                time,
                goods,
                divider,
                totalAmount,
                const Text('订单信息：')
                    .fontSize(14)
                    .fontWeight(FontWeightCompat.medium)
                    .textColor(Colors.white)
                    .paddingOnly(left: 22, right: 22, top: 35, bottom: 10),
                OrderDescription(descriptions: [])
                    .paddingSymmetric(horizontal: 22, vertical: 33),
              ],
            ),
          );
        }(),
      ),
    );
  }
}
