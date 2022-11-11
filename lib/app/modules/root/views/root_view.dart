import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/root/controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: currentRoute?.location ?? Routes.initial,
            delegate: delegate,
            anchorRoute: Routes.initial,
            filterPages: (afterAnchor) {
              return afterAnchor.take(1);
            },
          ),
        );
      },
    );
  }
}
