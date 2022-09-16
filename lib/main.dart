import 'package:flutter/material.dart';
import 'package:blockie_app/pages/project_groups.dart';
import 'package:blockie_app/pages/projects.dart';
import 'package:blockie_app/pages/user.dart';
import 'package:blockie_app/pages/brand_detail.dart';
import 'package:blockie_app/pages/project_detail.dart';
import 'package:blockie_app/pages/image_view.dart';
import 'package:blockie_app/pages/nft_detail.dart';
import 'package:blockie_app/common/routes.dart';
import 'package:get/get.dart';


void main() {
  // final routes = {
  //   "/": (context) => const ProjectListView(),
  //   "/user": (context) => const UserPage(),
  //   "/brand": (context) => const BrandPage(),
  //   "/project": (context) => const ProjectPage(),
  //   '/image_view': (context) => const ImageView(),
  //   '/nft': (context) => NftPage()
  // };

  final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const ProjectGroups(),
    ),
    GetPage(
      name: Routes.projects,
      page: () => const Projects(),
    ),
    GetPage(
      name: Routes.user,
      page: () => const UserPage(),
    ),
    GetPage(
      name: Routes.brand,
      page: () => const BrandPage(),
    ),
    GetPage(
      name: Routes.project,
      page: () => const ProjectPage(),
    ),
    GetPage(
      name: Routes.imageView,
      page: () => const ImageView(),
    ),
    GetPage(
      name: Routes.nft,
      page: () => const NftPage(),
    )
  ];

  runApp(GetMaterialApp(
    title: 'BLOCKIE',
    initialRoute: '/',
    getPages: pages,
    home: const ProjectGroups(),
  ));
}