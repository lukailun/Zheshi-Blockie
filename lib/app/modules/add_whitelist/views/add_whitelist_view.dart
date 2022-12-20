// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/add_whitelist/controllers/add_whitelist_controller.dart';
import 'package:blockie_app/app/modules/add_whitelist/models/add_whitelist_details.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/projects_management_footer_view.dart';
import 'package:blockie_app/widgets/projects_management_user_view.dart';

class AddWhitelistContainerView extends GetView<AddWhitelistController> {
  const AddWhitelistContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '加白名单'),
        body: () {
          final addWhitelistDetailsValue = controller.addWhitelistDetails.value;
          return Stack(
            children: [
              () {
                if (addWhitelistDetailsValue == null) {
                  return const SizedBox();
                } else {
                  return _AddWhitelistView(
                    addWhitelistDetails: addWhitelistDetailsValue,
                  ).paddingOnly(bottom: 182);
                }
              }(),
              ProjectsManagementFooterView(
                topButtonTitle: '添加用户至白名单',
                bottomButtonTitle: '继续扫码',
                topButtonIsEnabled: controller.addWhitelistButtonIsEnabled(),
                topButtonOnTap: controller.addWhitelist,
                bottomButtonOnTap: controller.scanQrCode,
              ),
            ],
          );
        }(),
      ),
    );
  }
}

class _AddWhitelistView extends StatelessWidget {
  final AddWhitelistDetails addWhitelistDetails;

  const _AddWhitelistView({
    required this.addWhitelistDetails,
  });

  @override
  Widget build(BuildContext context) {
    final userView = ProjectsManagementUserView(user: addWhitelistDetails.user);
    return Column(
      children: [
        Expanded(child: userView),
      ],
    );
  }
}
