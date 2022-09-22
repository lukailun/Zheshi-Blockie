import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;

  const BasicAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        }, // Image tapped
        child: Container(
          padding: const EdgeInsets.only(left: 22),
          child: Image.asset(
            "images/back.png",
            width: 40,
            height: 40,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      toolbarHeight: 80,
      title: Text(title ?? '')
          .textColor(Colors.white)
          .fontSize(20)
          .fontWeight(FontWeightCompat.bold),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
