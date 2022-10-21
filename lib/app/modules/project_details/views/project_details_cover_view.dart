// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';

class ProjectDetailsCoverView extends StatelessWidget {
  final ProjectDetails projectDetails;
  final Function(int) galleryOnTap;

  const ProjectDetailsCoverView({
    Key? key,
    required this.projectDetails,
    required this.galleryOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: projectDetails.coverUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                const Expanded(child: SizedBox()),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: projectDetails.imageUrls.length,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => galleryOnTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color(0x66FFFFFF),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                          ),
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: projectDetails.imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 5);
                    },
                  ),
                ).paddingOnly(bottom: 22),
              ],
            )
          ],
        ),
      ),
    );
  }
}
