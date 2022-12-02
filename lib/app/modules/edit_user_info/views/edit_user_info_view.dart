// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/edit_user_info/controllers/edit_user_info_controller.dart';
import 'package:blockie_app/app/modules/edit_user_info/models/edit_user_info_item.dart';
import 'package:blockie_app/app/modules/edit_user_info/views/edit_user_info_item_tile.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';

class EditUserInfoView extends GetView<EditUserInfoController> {
  const EditUserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeData.primaryColor,
        appBar: BasicAppBar(title: '编辑资料'),
        body: () {
          final userInfo = controller.userInfo.value;
          if (userInfo == null) {
            return const LoadingIndicator();
          } else {
            final items = EditUserInfoItem.initial(
              userInfo: userInfo,
              usernameOnTap: controller.goToUpdateUsername,
              bioOnTap: controller.goToUpdateBio,
              genderOnTap: controller.goToUpdateGender,
              birthdayOnTap: controller.goToUpdateBirthday,
              regionOnTap: controller.goToUpdateRegion,
            );
            return SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: controller.goToUpdateAvatar,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(36)),
                        child: CachedNetworkImage(
                          imageUrl: userInfo.avatarUrl,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).paddingOnly(bottom: 84),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          EditUserInfoItemTile(item: items[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 14),
                      itemCount: items.length,
                    ),
                  ],
                ),
              ),
            );
          }
        }(),
      ),
    );
  }
}
