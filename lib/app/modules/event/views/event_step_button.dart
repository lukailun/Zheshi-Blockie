import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../models/event_step.dart';

class EventStepButton extends StatelessWidget {
  final int index;
  final String title;
  final EventStepStatus status;
  final bool isEnabled;
  final GestureTapCallback? onTap;

  const EventStepButton({
    Key? key,
    required this.index,
    required this.title,
    required this.status,
    this.isEnabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasDone = status == EventStepStatus.done;
    return PointerInterceptor(
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1AFFFFFF),
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(-1, -1),
              ),
              BoxShadow(
                color: Color(0xFF000000),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(index.toString())
                  .withoutUnderLine()
                  .textColor(AppThemeData.primaryColor)
                  .fontWeight(FontWeightCompat.regular)
                  .fontSize(16),
              Text(title)
                  .withoutUnderLine()
                  .textColor(AppThemeData.primaryColor)
                  .fontWeight(FontWeightCompat.regular)
                  .fontSize(16)
                  .paddingSymmetric(horizontal: 28),
              const Expanded(child: SizedBox()),
              Image.asset(
                "images/event/${hasDone ? "done" : "arrow"}.png",
                color: hasDone ? null : AppThemeData.primaryColor,
              ),
            ],
          ).paddingSymmetric(horizontal: 28),
        ),
      ),
    );
  }
}
