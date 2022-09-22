import 'package:flutter/material.dart';

class EmptyDatasetView extends StatelessWidget {
  const EmptyDatasetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'images/empty_dataset.png',
            width: 180,
            height: 100,
          ),
          const SizedBox(height: 16),
          const Text(
            '什么都没有哦',
            style: TextStyle(color: Color(0xff6d8cff), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
