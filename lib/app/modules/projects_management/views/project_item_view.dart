// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/models/project.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';

class ProjectItemView extends StatelessWidget {
  final Project project;
  final Function()? onTap;

  const ProjectItemView({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final coverUrl = project.coverUrl ?? '';
    final cover = AspectRatio(
      aspectRatio: 332.0 / 250.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: coverUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: project.coverUrl ?? '',
                fit: BoxFit.cover,
              )
            : const SizedBox(),
      ),
    ).paddingOnly(bottom: 16);
    final title = Text(project.title)
        .textColor(Colors.white)
        .fontSize(21)
        .paddingOnly(left: 16, right: 16, bottom: 16);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: AppThemeData.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cover,
            title,
          ],
        ),
      ),
    ).outlined().paddingOnly(bottom: 11);
  }
}
