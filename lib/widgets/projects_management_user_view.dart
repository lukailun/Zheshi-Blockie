// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/projects_management_user.dart';
import 'ellipsized_text.dart';

class ProjectsManagementUserView extends StatelessWidget {
  final ProjectsManagementUser user;

  const ProjectsManagementUserView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('实名手机号：${_displayPhoneNumber(user.phoneNumber ?? '')}')
            .textColor(Colors.white)
            .fontSize(16)
            .paddingSymmetric(vertical: 8),
        const Divider(color: Color(0x1AFFFFFF), thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('区块链地址：')
                .textColor(Colors.white)
                .fontSize(16)
                .paddingSymmetric(vertical: 8),
            SizedBox(
              width: 160,
              child: EllipsizedText(
                user.walletAddress ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.white),
                ellipsis: Ellipsis.middle,
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
        const Divider(color: Color(0x1AFFFFFF), thickness: 1),
        Text('白名单状态：${user.isQualified ? '已在白名单' : '未在白名单'}')
            .textColor(
                user.isQualified ? Colors.white : const Color(0xFFFF8F1F))
            .fontSize(16)
            .paddingSymmetric(vertical: 8),
        const Divider(color: Color(0x1AFFFFFF), thickness: 1),
      ],
    ).paddingSymmetric(horizontal: 59, vertical: 23);
  }

  String _displayPhoneNumber(String phone) {
    if (phone.length != 11) {
      return phone;
    }
    return "${phone.substring(0, 3)}****${phone.substring(phone.length - 4)}";
  }
}
