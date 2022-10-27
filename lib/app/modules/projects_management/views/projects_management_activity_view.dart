// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/models/projects.dart';
import 'package:blockie_app/extensions/extensions.dart';

class ProjectsManagementActivityView extends StatelessWidget {
  final Projects projects;
  final Function() onTap;
  final Function() issuerOnTap;
  final bool showsIssuer;

  const ProjectsManagementActivityView({
    super.key,
    required this.projects,
    required this.onTap,
    required this.issuerOnTap,
    this.showsIssuer = true,
  });

  @override
  Widget build(BuildContext context) {
    final cover = SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: projects.projects.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final coverUrl = projects.projects[index].coverUrl ?? '';
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Stack(
              children: [
                coverUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: coverUrl,
                        width: 280,
                        height: 280,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(),
                Column(
                  children: [
                    const Spacer(flex: 1),
                    Container(
                      width: 280,
                      height: 70,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x00757575),
                            Color(0xFF404040),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 20,
                  bottom: 13,
                  width: 240,
                  child: Text(
                    projects.projects[index].name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ).textColor(Colors.white).fontSize(20),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
      ),
    ).paddingSymmetric(vertical: 16);
    final title = Text(projects.name)
        .textColor(Colors.white)
        .fontSize(21)
        .paddingOnly(left: 16, right: 16, bottom: 16);
    final summary = Visibility(
      visible: projects.summary.isNotEmpty,
      child: Text(
        projects.summary,
        maxLines: 3,
      )
          .textColor(const Color(0xB3FFFFFF))
          .fontSize(14)
          .paddingOnly(left: 16, right: 16, bottom: 16),
    );
    final brandInfo = Visibility(
      visible: showsIssuer,
      child: GestureDetector(
        onTap: issuerOnTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: projects.issuer.avatarUrl,
                width: 40,
                height: 40,
              ),
            ),
            Text(projects.issuer.name)
                .fontSize(14)
                .textColor(const Color(0xB3FFFFFF))
                .paddingOnly(left: 7),
            const Spacer(flex: 1),
          ],
        ),
      ).paddingOnly(left: 16, right: 16, bottom: 16),
    );
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cover,
          title,
          summary,
          brandInfo,
        ],
      ),
    ).outlined().paddingSymmetric(horizontal: 22, vertical: 11);
  }
}
