import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/blur.dart';
import 'package:blockie_app/widgets/expand_tap_area.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/order_creation/controllers/order_creation_controller.dart';

class OrderCreationView extends GetView<OrderCreationController> {
  const OrderCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '订单确认'),
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
                  '上海 ·徐汇XXX篮球场',
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
          final test = ['3V3 女子赛报名门票', '纪念飞盘'];
          final goods = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: test.map((it) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(it)
                      .fontSize(14)
                      .fontWeight(FontWeightCompat.mostThick)
                      .textColor(Colors.white),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('¥ 220')
                            .fontSize(14)
                            .fontWeight(FontWeightCompat.bold)
                            .textColor(Colors.white),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text('剩余 21 张')
                            .fontSize(14)
                            .textColor(const Color(0x80FFFFFF)),
                      ),
                      ExpandTapWidget(
                        onTap: () {},
                        tapPadding: const EdgeInsets.all(10),
                        child: BasicIconButton(
                          assetName:
                              'assets/images/order_creation/decrease.png',
                          size: 16,
                          onTap: () {},
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: Text('1')
                            .fontSize(14)
                            .fontWeight(FontWeightCompat.bold)
                            .textAlignment(TextAlign.center)
                            .textColor(const Color(0x80FFFFFF)),
                      ),
                      ExpandTapWidget(
                        onTap: () {},
                        tapPadding: const EdgeInsets.all(10),
                        child: BasicIconButton(
                          assetName:
                              'assets/images/order_creation/increase.png',
                          size: 16,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 10),
                ],
              ).paddingSymmetric(horizontal: 22, vertical: 16);
            }).toList(),
          ).outlined().paddingSymmetric(horizontal: 22);
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 143),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    location,
                    time,
                    divider,
                    const Text('票种选择：')
                        .fontSize(14)
                        .fontWeight(FontWeightCompat.medium)
                        .textColor(Colors.white)
                        .paddingOnly(left: 22, right: 22, top: 35, bottom: 10),
                    goods,
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white24, width: 1))),
                  width: double.infinity,
                  height: 130,
                  child: ClipRect(
                    child: Blur(
                      blurColor: const Color(0x10FFFFFF),
                      colorOpacity: 0.05,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('合计：')
                                    .fontSize(16)
                                    .textColor(Colors.white),
                                Text('¥ 200')
                                    .fontSize(24)
                                    .textColor(Colors.white),
                              ],
                            ),
                            const Spacer(flex: 1),
                            SizedBox(
                              width: 150,
                              height: 48,
                              child: BasicElevatedButton(
                                title: '去支付',
                                borderRadius: 8,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                textFontSize: 16,
                                onTap: () {},
                              ),
                            )
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 22),
                    ),
                  ),
                ),
              ),
            ],
          );
        }(),
      ),
    );
  }
}
