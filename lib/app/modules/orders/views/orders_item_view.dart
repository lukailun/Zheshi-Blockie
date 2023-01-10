import 'package:blockie_app/app/modules/orders/models/order.dart';
import 'package:blockie_app/app/modules/orders/models/order_status.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersItemView extends StatelessWidget {
  final Order order;
  final Function()? onTap;

  const OrdersItemView({
    super.key,
    required this.order,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            order.subactivity.name,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          )
              .fontSize(14)
              .fontWeight(FontWeightCompat.bold)
              .textColor(Colors.white),
        ),
        Text(order.status.displayValue)
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
          visible: !order.subactivity.isOnline,
          child: Image.asset(
            'assets/images/activities/location.png',
            width: 10,
            height: 12,
            fit: BoxFit.contain,
          ).paddingOnly(right: 4),
        ),
        Flexible(
          child: Text(
            order.subactivity.location,
            overflow: TextOverflow.ellipsis,
          )
              .fontSize(10)
              .textColor(const Color(0x80FFFFFF))
              .paddingOnly(right: 4),
        ),
      ],
    );
    final time = Text(
      order.subactivity.startedTime ?? '',
      overflow: TextOverflow.ellipsis,
    ).fontSize(10).textColor(const Color(0x80FFFFFF)).paddingOnly(top: 4);
    final goods = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: order.goods.where((it) => it.amount > 0).map((it) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(it.name).fontSize(12).textColor(Colors.white),
                ),
                Text(it.price.toDisplayPrice())
                    .fontSize(14)
                    .fontWeight(FontWeightCompat.bold)
                    .textColor(Colors.white)
              ],
            ),
            Text('× ${it.amount}')
                .fontSize(10)
                .textColor(const Color(0x99FFFFFF)),
          ],
        ).paddingOnly(top: 2, bottom: 8);
      }).toList(),
    );
    final totalAmount = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text('共 ${order.totalAmount} 件')
              .fontSize(10)
              .textColor(const Color(0x99FFFFFF)),
        ),
        Text(order.totalPrice.toDisplayPrice())
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
