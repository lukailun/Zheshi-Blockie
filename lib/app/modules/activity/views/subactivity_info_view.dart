// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/extensions/extensions.dart';

class SubactivityInfoView extends StatelessWidget {
  final String title;
  final Function()? onLocationTap;
  final Function()? onPhoneTap;
  final Function()? onWechatTap;

  const SubactivityInfoView({
    super.key,
    required this.title,
    this.onLocationTap,
    this.onPhoneTap,
    this.onWechatTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title)
              .textColor(AppThemeData.secondaryColor)
              .fontSize(18)
              .fontWeight(FontWeightCompat.bold)
              .paddingOnly(bottom: 11),
          _getItem(
            leadingAssetName: 'assets/images/activity/time.png',
            value: '活动时间：2022/12/22   08:00',
          ),
          _getItem(
            leadingAssetName: 'assets/images/activity/location.png',
            value: '上海市徐汇区篮球馆',
            trailingAssetName: 'assets/images/common/location.png',
            onTap: onLocationTap,
          ),
          _getItem(
            leadingAssetName: 'assets/images/activity/phone.png',
            value: '021-782978348 ',
            trailingAssetName: 'assets/images/common/phone.png',
            onTap: onPhoneTap,
          ),
          _getItem(
            leadingAssetName: 'assets/images/activity/wechat.png',
            value: 'NDSNKSDNKL',
            trailingAssetName: 'assets/images/common/copy.png',
            onTap: onWechatTap,
          ),
        ],
      ),
    )
        .paddingOnly(top: 11, bottom: 16, left: 10, right: 10)
        .outlined()
        .paddingSymmetric(vertical: 14);
  }

  Widget _getItem({
    required String leadingAssetName,
    required String value,
    String? trailingAssetName,
    Function()? onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(leadingAssetName, width: 20, height: 20),
        Expanded(
          child: Text(value)
              .textColor(Colors.white)
              .fontSize(14)
              .fontWeight(FontWeightCompat.medium)
              .paddingSymmetric(horizontal: 10),
        ),
        Visibility(
          visible: (trailingAssetName ?? '').isNotEmpty,
          child: GestureDetector(
            onTap: onTap,
            child: Image.asset(trailingAssetName ?? '', width: 22, height: 22),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 14, vertical: 8);
  }
}
