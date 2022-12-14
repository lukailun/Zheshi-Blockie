// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

part 'gallery_controller_router.dart';

class GalleryController extends GetxController {
  final pageController = PageController();
  final imageUrlsString = Get.parameters[GalleryParameter.imageUrls] as String;
  final index = Get.parameters[GalleryParameter.index] as String;
  List<String> imageUrls = [];
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    imageUrls = (jsonDecode(imageUrlsString) as List)
        .map((it) => it as String)
        .toList();
    currentIndex.value = int.parse(index);
  }

  @override
  void onReady() {
    super.onReady();
    pageController.jumpToPage(currentIndex.value);
  }
}

class GalleryParameter {
  static const imageUrls = 'imageUrls';
  static const index = 'index';
}
