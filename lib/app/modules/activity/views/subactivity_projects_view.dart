// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/project.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/mint_status.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/html_video.dart';

class SubactivityProjectsView extends StatelessWidget {
  final Subactivity subactivity;
  final List<MintStatus> mintStatuses;
  final Function(String)? detailsOnTap;
  final Function(Project, MintStatus)? mintOnTap;

  List<Project> get projects => subactivity.projects;

  const SubactivityProjectsView({
    super.key,
    required this.subactivity,
    required this.mintStatuses,
    this.detailsOnTap,
    this.mintOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text(projects.isNotEmpty ? projects.first.category : '')
                .textColor(AppThemeData.secondaryColor)
                .fontSize(18)
                .fontWeight(FontWeightCompat.bold)
                .paddingSymmetric(horizontal: 10),
          ] +
          projects
              .asMap()
              .entries
              .map((it) => _getBenefitView(it.key))
              .toList(),
    )
        .paddingOnly(top: 11, bottom: 24)
        .outlined()
        .paddingSymmetric(vertical: 14);
  }

  Widget _getBenefitView(int index) {
    final project = projects[index];
    final mintStatus = mintStatuses[index];
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                project.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
                  .textColor(Colors.white)
                  .fontWeight(FontWeightCompat.mostThick)
                  .fontSize(14),
            ),
            GestureDetector(
              onTap: () => detailsOnTap?.call(project.id),
              behavior: HitTestBehavior.translucent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('详情')
                      .textColor(const Color(0x80FFFFFF))
                      .fontSize(14)
                      .paddingOnly(right: 2),
                  const BasicIconButton(
                      assetName: 'assets/images/common/arrow.png', size: 22),
                ],
              ),
            ).paddingOnly(left: 10),
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 14),
        AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: () {
            if (project.isVideoNft) {
              final showsPreview = mintStatus.showsPreviewVideo;
              final video = showsPreview ? project.previewVideo : project.video;
              return HtmlVideo(
                url: video?.url ?? '',
                posterUrl: video?.posterUrl,
                autoplay: false,
                muted: false,
              );
            } else {
              return CachedNetworkImage(
                imageUrl: project.coverUrl ?? '',
                fit: BoxFit.contain,
              );
            }
          }(),
        ),
        Visibility(
          visible: subactivity.steps.isNotEmpty,
          child: Text(mintStatus.message(
            category: subactivity.steps.isNotEmpty
                ? subactivity.steps.first.category
                : '',
            isVideoNft: project.isVideoNft,
          ))
              .textColor(const Color(0x80FFFFFF))
              .fontSize(13)
              .paddingOnly(top: 10, left: 10, right: 10),
        ),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: BasicElevatedButton(
            title: mintStatus.title(
              startedTime: project.startedTime,
              isVideoNft: project.isVideoNft,
            ),
            borderRadius: 8,
            textColor: const Color(0xFF3D3D3D),
            backgroundColors:
                mintStatus.colorValues?.map((it) => Color(it)).toList(),
            backgroundColorsStops: const [0, 0.5, 0.5, 1],
            backgroundColor: Color(mintStatus.colorValue),
            disabledColor: Color(mintStatus.colorValue),
            textFontSize: 18,
            isEnabled: mintStatus.enabled,
            onTap: mintStatus.enabled
                ? () => mintOnTap?.call(project, mintStatus)
                : null,
          ),
        ).paddingOnly(left: 22, right: 22, top: 15),
      ],
    );
  }
}
