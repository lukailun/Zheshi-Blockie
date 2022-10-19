// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/update_avatar/controllers/update_avatar_controller.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/html_image.dart';

class UpdateAvatarView extends GetView<UpdateAvatarController> {
  const UpdateAvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarImage = HtmlImage(url: controller.initialAvatar.value);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BasicAppBar(title: '我的头像'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: avatarImage,
          ).paddingOnly(bottom: 20),
        ),
      ),
    );
  }
}
