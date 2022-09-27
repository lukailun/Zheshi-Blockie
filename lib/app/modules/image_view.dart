import 'package:blockie_app/models/project_detail_info.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:flutter/material.dart';
import 'package:blockie_app/models/global.dart';
import 'package:get/get.dart';
import 'package:blockie_app/widgets/screen_bound.dart';

class ImageView extends StatefulWidget{
  const ImageView({Key? key}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late PageController controller;
  int currentIndex = 0;
  var imageUrls = <String>[];

  @override
  void initState() {
    controller = PageController();
    Future.delayed(Duration.zero,() async {
      ProjectDetailInfo project = await HttpRequest.loadProjectDetail(uid: Get.parameters["projectUid"]!);
      setState(() {
        imageUrls = project.images;
        currentIndex = int.parse(Get.parameters["index"]!);
        controller.jumpToPage(currentIndex);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget swiper = PageView.builder(
        itemCount: imageUrls.length,
        controller: controller,
        // pageSnapping: true,
        itemBuilder: (context, index) {
          return Image.network(
            imageUrls[index],
            fit: BoxFit.contain,
          );
        },
        onPageChanged: (int index){
          setState(() {
            currentIndex = index;
          });
        },
    );

    Widget title = Container(
      padding: const EdgeInsets.only(left: 19, right: 19, top: Global.titleButtonTop),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              }, // Image tapped
              child: Image.asset(
                "images/back.png",
                width: 40,
                height: 40,
              )
          ),
          Expanded(
              child: Text(
                "${currentIndex + 1}/${imageUrls.length}",
                style: const TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              )
          ),
          Container(
            width: 29,
          )
        ],
      ),
    );

    // return Material(
    //   color: const Color(0xff3c63f8),
    //   child: Column(
    //     children: [
    //       title,
    //       Expanded(child: swiper),
    //       Container(height: 79,)
    //     ],
    //   )
    // );
    return ScreenBoundary(
        body: Column(
          children: [
            title,
            Expanded(child: swiper),
            Container(height: 79,)
          ],
        ),
        padding: 0,
    );
  }
}
