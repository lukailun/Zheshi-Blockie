import 'package:blockie_app/app/modules/orders/views/orders_item_view.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/blur.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/orders/controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '我的订单'),
        body: () {
          final orders = controller.orders.value;
          if (orders == null) {
            return const LoadingIndicator();
          }
          return Stack(
            children: [
              ListView.separated(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.only(left: 22, right: 22, bottom: 143),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrdersItemView(order: order);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 26),
                itemCount: orders.length,
              ),
              Visibility(
                visible: false,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white24, width: 1)),
                    ),
                    width: double.infinity,
                    height: 130,
                    child: ClipRect(
                      child: Blur(
                        blurColor: const Color(0x10FFFFFF),
                        colorOpacity: 0.05,
                        child: Center(
                          child: SizedBox(
                            height: 48,
                            child: BasicElevatedButton(
                              title: '再次购买',
                              borderRadius: 8,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              textFontSize: 18,
                              onTap: () {},
                            ),
                          ).paddingSymmetric(horizontal: 22),
                        ),
                      ),
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
