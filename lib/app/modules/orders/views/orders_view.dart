import 'package:blockie_app/app/modules/orders/views/orders_item_view.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
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
          // final orders = controller.orders.value;
          final orders = [controller.a.value, 'b', 'c'];
          if (orders == null) {
            return const LoadingIndicator();
          }

          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrdersItemView();
            },
            separatorBuilder: (context, index) => const SizedBox(height: 26),
            itemCount: orders.length,
          );
        }(),
      ),
    );
  }
}
