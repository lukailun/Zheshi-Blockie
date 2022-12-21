import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersItemView extends StatelessWidget {
  final Function()? onTap;

  const OrdersItemView({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '2022上海市篮球冠军联赛',
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          )
              .fontSize(14)
              .fontWeight(FontWeightCompat.bold)
              .textColor(Colors.white),
        ),
        Text('已完成')
            .fontSize(12)
            .textColor(const Color(0x80FFFFFF))
            .paddingSymmetric(horizontal: 7),
        Image.asset(
          'assets/images/orders/arrow.png',
          width: 7,
          height: 13,
        ),
      ],
    ).paddingOnly(top: 18, bottom: 14);
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
    );
    final time = Text(
      '9月30日 周六 18:00',
      overflow: TextOverflow.ellipsis,
    )
        .fontSize(10)
        .textColor(const Color(0x80FFFFFF))
        .paddingOnly(top: 4);
    final test = ['3V3 女子赛报名门票', '纪念飞盘'];
    final goods = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: test.map((it) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(it).fontSize(12).textColor(Colors.white),
                ),
                Text('¥ 220')
                    .fontSize(14)
                    .fontWeight(FontWeightCompat.bold)
                    .textColor(Colors.white)
              ],
            ),
            Text('× 1').fontSize(10).textColor(const Color(0x99FFFFFF)),
          ],
        ).paddingOnly(top: 2, bottom: 8);
      }).toList(),
    );
    final totalAmount = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text('共 2 件').fontSize(10).textColor(const Color(0x99FFFFFF)),
        ),
        Text('¥ 220')
            .fontSize(14)
            .fontWeight(FontWeightCompat.bold)
            .textColor(Colors.white),
      ],
    ).paddingOnly(top: 8, bottom: 16);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          location,
          time,
          goods,
          totalAmount,
        ],
      ).paddingSymmetric(horizontal: 20).outlined(),
    );
  }
}
