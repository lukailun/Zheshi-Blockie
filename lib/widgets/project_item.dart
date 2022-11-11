// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/app/modules/project_details/controllers/project_details_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/issuer.dart';
import 'package:blockie_app/models/project_group.dart';
import 'package:blockie_app/models/project_info.dart';

const double imageItemPadding = 16;
const double groupImageWidth = 280;

Widget createProjectItemMixed(ProjectGroup inGroup,
    {Function? whenBack, bool showBrand = true}) {
  if (inGroup.type == 1) {
    return createProjectItemSingle(inGroup.projects[0],
        whenBack: whenBack, showBrand: showBrand);
  }
  return GestureDetector(
      onTap: () {
        final parameters = {
          ActivityParameter.id: inGroup.uid,
        };
        Get.toNamed(Routes.activity, parameters: parameters)?.then((_) {
          whenBack?.call();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 32),
        child: ProjectItem(
          projectGroup: inGroup,
          showBrand: showBrand,
        ),
      ));
}

Widget createProjectItemSingle(ProjectInfo info,
    {Function? whenBack, bool showBrand = true}) {
  return GestureDetector(
      onTap: () {
        final parameters = {ProjectDetailsParameter.id: info.uid};
        Get.toNamed(Routes.projectDetails, parameters: parameters)?.then((_) {
          whenBack?.call();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 32),
        child: ProjectItem(
          projectInfo: info,
          showBrand: showBrand,
        ),
      ));
}

class ProjectItem extends StatelessWidget {
  ProjectInfo? projectInfo;
  ProjectGroup? projectGroup;
  bool showBrand;

  ProjectItem(
      {Key? key, this.projectInfo, this.projectGroup, this.showBrand = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (projectInfo == null && projectGroup == null) {
      return const SizedBox(height: 0);
    }

    bool isGroup = projectGroup != null;
    Issuer issuer =
        isGroup ? projectGroup!.projects[0].issuer : projectInfo!.issuer;
    String name = isGroup ? projectGroup!.name : projectInfo!.name;
    String summary = isGroup ? projectGroup!.summary : projectInfo!.summary;

    double summaryHeight = isGroup ? 80 : 40;
    int summaryLines = isGroup ? 3 : 2;
    Widget cover = isGroup
        ? Container(
            padding: const EdgeInsets.only(
                top: imageItemPadding, bottom: imageItemPadding),
            height: groupImageWidth + imageItemPadding * 2,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: projectGroup!.projects.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox(
                      width: imageItemPadding,
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.only(right: imageItemPadding),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Stack(
                        children: [
                          Image.network(
                            projectGroup!.projects[index - 1].cover,
                            width: groupImageWidth,
                            height: groupImageWidth,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              const Spacer(flex: 1),
                              Container(
                                width: groupImageWidth,
                                height: groupImageWidth / 4,
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
                              left: 21,
                              bottom: 13,
                              width: groupImageWidth - 30,
                              child: Text(
                                projectGroup!.projects[index - 1].name,
                                style: const TextStyle(
                                    color: Color(0xffffffff), fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ))
                        ],
                      ),
                    ),
                  );
                }),
          )
        : AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                projectInfo!.cover,
                fit: BoxFit.cover,
              ),
            ),
          );

    Widget textCol = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 21,
              color: Color(0xffffffff),
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Color.fromARGB(125, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(-2, -2),
                  blurRadius: 2,
                  color: Color.fromARGB(25, 255, 255, 255),
                ),
              ]),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            height: summaryHeight,
            child: Center(
              child: Text(
                summary,
                softWrap: true,
                style: const TextStyle(fontSize: 14, color: Color(0xb3ffffff)),
                maxLines: summaryLines,
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        showBrand
            ? GestureDetector(
                onTap: () {
                  final parameters = {
                    'issuerUid': issuer.id,
                  };
                  Get.toNamed(Routes.brand, parameters: parameters);
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(issuer.logoUrl ?? ''),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(issuer.title,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xb3ffffff))),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(isGroup ? '' : '共发行 ${projectInfo!.totalAmount}',
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xb3ffffff)))
                  ],
                ),
              )
            : const SizedBox(
                height: 0,
              )
      ],
    );

    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          cover,
          Container(
            padding: const EdgeInsets.all(imageItemPadding),
            child: textCol,
          )
        ],
      ),
    ).outlined();
  }
}
