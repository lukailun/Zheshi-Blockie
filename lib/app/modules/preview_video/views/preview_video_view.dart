import 'package:blockie_app/models/app_theme_data.dart';
import 'package:blockie_app/models/mint_status.dart';
import 'package:blockie_app/widgets/basic_app_bar.dart';
import 'package:blockie_app/widgets/basic_elevated_button.dart';
import 'package:blockie_app/widgets/html_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/preview_video/controllers/preview_video_controller.dart';

class PreviewVideoView extends GetView<PreviewVideoController> {
  const PreviewVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.primaryColor,
      appBar: BasicAppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppThemeData.primaryColor,
        child: Stack(
          children: [
            Center(
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
            Positioned(
              left: 22,
              right: 22,
              bottom: 50,
              child: SizedBox(
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
                          title: '返回',
                          borderRadius: 8,
                          textColor: const Color(0xFF3D3D3D),
                          backgroundColor: Colors.white,
                          textFontSize: 18,
                          onTap: controller.back,
                        ),
                      ),
                    );
                    children.add(previewButton);
                    children.add(const Spacer(flex: 10));
                    final mintButton = Expanded(
                      flex: 295,
                      child: SizedBox(
                        height: 52,
                        child: BasicElevatedButton(
                          title: MintStatus.mintable.title(isVideo: true),
                          borderRadius: 8,
                          textColor: const Color(0xFF3D3D3D),
                          backgroundColor: Colors.white,
                          textFontSize: 18,
                          onTap: () => controller.back(result: true),
                        ),
                      ),
                    );
                    children.add(mintButton);
                    return children;
                  }(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
