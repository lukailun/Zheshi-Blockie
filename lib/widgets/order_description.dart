import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDescription extends StatelessWidget {
  final List<String> descriptions;

  const OrderDescription({
    Key? key,
    required this.descriptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: descriptions.map((it) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('·')
                .fontSize(12)
                .textColor(const Color(0xFFA5A5A5))
                .paddingSymmetric(horizontal: 8),
            Expanded(
              child: Text(it, maxLines: 100)
                  .fontSize(12)
                  .textColor(const Color(0xFFA5A5A5)),
            ),
          ],
        );
      }).toList(),
    );
  }
}
