// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/profile/models/profile_label.dart';
import 'package:blockie_app/app/modules/profile/views/label_view.dart';
import 'package:blockie_app/extensions/extensions.dart';

extension GetDialogExtension on GetInterface {
  void updateLabelsDialog({
    required List<ProfileLabel> labels,
    Function(String)? labelOnTap,
  }) {
    Get.dialog(
      UpdateLabelsDialog(
        labels: labels,
        labelOnTap: labelOnTap,
      ),
      barrierColor: Colors.transparent,
    );
  }
}

class UpdateLabelsDialog extends StatelessWidget {
  final List<ProfileLabel> labels;
  final Function(String)? labelOnTap;

  const UpdateLabelsDialog({
    super.key,
    required this.labels,
    this.labelOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        SizedBox(
          width: double.infinity,
          child: ClipRect(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: const Color(0x4DFFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('选择你感兴趣的项目')
                          .fontSize(13)
                          .textColor(Colors.black)
                          .fontWeight(FontWeight.bold)
                          .paddingOnly(left: 32, right: 22, top: 32),
                      GridView.count(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 5,
                        children: labels
                            .map((it) => GestureDetector(
                                  onTap: () => labelOnTap?.call(it.id),
                                  child: LabelView(label: it),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    ).paddingSymmetric(horizontal: 22);
  }
}
