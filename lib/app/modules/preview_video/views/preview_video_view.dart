import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/html_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/preview_video/controllers/preview_video_controller.dart';

class PreviewVideoView extends GetView<PreviewVideoController> {
  const PreviewVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BasicAppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: HtmlVideo(
              url: controller.url,
              posterUrl: controller.posterUrl,
              autoplay: true,
              muted: false,
            ),
          ),
        ),
      ),
    );
  }
}
