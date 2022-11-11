// Flutter imports:
import 'package:blockie_app/app/modules/activity/models/nft_type.dart';
import 'package:blockie_app/app/modules/activity/models/project.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/mint_status.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:blockie_app/widgets/html_video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

class SubactivityProjectsView extends StatelessWidget {
  final List<Project> projects;
  final List<MintStatus> mintStatuses;
  final Function(String)? detailsOnTap;
  final Function(String, String)? previewOnTap;
  final Function(Project, MintStatus)? mintOnTap;

  const SubactivityProjectsView({
    super.key,
    required this.projects,
    required this.mintStatuses,
    this.detailsOnTap,
    this.previewOnTap,
    this.mintOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text(projects.first.category)
                .textColor(AppThemeData.secondaryColor)
                .fontSize(18)
                .fontWeight(FontWeightCompat.bold)
                .paddingZero,
          ] +
          projects
              .asMap()
              .entries
              .map((it) => _getBenefitView(it.key))
              .toList(),
    )
        .paddingOnly(top: 11, bottom: 24, left: 10, right: 10)
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('详情')
                      .textColor(const Color(0x80FFFFFF))
                      .fontSize(14)
                      .paddingOnly(right: 2),
                  const BasicIconButton(
                      assetName: 'assets/images/activity/arrow.png', size: 22),
                ],
              ),
            ).paddingOnly(left: 10),
          ],
        ).paddingOnly(top: 27, bottom: 27),
        Visibility(
          visible: (project.videoUrl ?? '').isNotEmpty ||
              (project.coverUrl ?? '').isNotEmpty,
          child: AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: (project.videoUrl ?? '').isNotEmpty
                ? HtmlVideo(
                    url: project.videoUrl ?? '',
                    posterUrl: project.coverUrl,
                    autoplay: false,
                    muted: false,
                  )
                : CachedNetworkImage(
                    imageUrl: project.coverUrl ?? '',
                    fit: BoxFit.contain,
                  ),
          ).paddingSymmetric(horizontal: 27),
        ),
        Visibility(
          visible: project.summary.isNotEmpty,
          child: Text(project.summary)
              .textColor(const Color(0x80FFFFFF))
              .fontSize(13)
              .paddingOnly(top: 10),
        ),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: Row(
            children: () {
              final children = <Widget>[];
              final previewButton = Expanded(
                flex: 95,
                child: SizedBox(
                  height: 52,
                  child: BasicElevatedButton(
                    title: '预览',
                    borderRadius: 8,
                    textColor: const Color(0xFF3D3D3D),
                    backgroundColor: Color(mintStatus.colorValue),
                    textFontSize: 18,
                    // isEnabled: mintStatus.previewEnabled, // fix disable bg color
                    onTap: mintStatus.previewEnabled
                        ? () => previewOnTap?.call(
                            project.videoUrl ?? '', project.coverUrl ?? '')
                        : null,
                  ),
                ),
              );
              if (mintStatus.showsPreview &&
                  (project.videoUrl ?? '').isNotEmpty) {
                children.add(previewButton);
                children.add(const Spacer(flex: 10));
              }
              final mintButton = Expanded(
                flex: 295,
                child: SizedBox(
                  height: 52,
                  child: BasicElevatedButton(
                    title: mintStatus.title(
                      startedTime: project.startedTime,
                      isVideo: project.nftType == NftType.video,
                    ),
                    borderRadius: 8,
                    textColor: const Color(0xFF3D3D3D),
                    backgroundColor: Color(mintStatus.colorValue),
                    textFontSize: 18,
                    // isEnabled: mintStatus.enabled, // fix disable bg color
                    onTap: mintStatus.enabled
                        ? () => mintOnTap?.call(project, mintStatus)
                        : null,
                  ),
                ),
              );
              children.add(mintButton);
              return children;
            }(),
          ),
        ).paddingOnly(left: 12, right: 12, top: 15),
      ],
    );
  }
}
