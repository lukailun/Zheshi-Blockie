// Dart imports:
import 'dart:math';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/environment.dart';
import 'package:blockie_app/data/models/platform_info.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
import 'package:blockie_app/widgets/message_toast.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statsfl/statsfl.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/common_repository.dart';
import 'package:blockie_app/services/debug_service.dart';

class BlockieApp extends StatelessWidget {
  final AccountRepository accountRepository;
  final CommonRepository commonRepository;
  final ProfileRepository profileRepository;
  final ProjectRepository projectRepository;
  final ProjectsManagementRepository projectsManagementRepository;

  const BlockieApp({
    super.key,
    required this.accountRepository,
    required this.commonRepository,
    required this.profileRepository,
    required this.projectRepository,
    required this.projectsManagementRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return StatsFl(
          isEnabled:
              Environment.isDevelopment && DebugService.to.showsFps.value,
          maxFps: 120,
          align: Alignment.bottomLeft,
          child: GetMaterialApp.router(
            title: DebugService.to.isDevTitle.value
                ? Environment.appTitle
                : Environment.appTitle.replaceAll('[DEV] ', ''),
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.cupertino,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(elevation: 0),
              fontFamily: '--apple-system',
            ),
            getPages: AppPages(
              accountRepository: accountRepository,
              commonRepository: commonRepository,
              profileRepository: profileRepository,
              projectRepository: projectRepository,
              projectsManagementRepository: projectsManagementRepository,
            ).routes,
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: Material(
                  color: const Color(0xFFF0F2F5),
                  child: WillPopScope(
                    onWillPop: () async {
                      MessageToast.showMessage('onWillPop');
                      return false;
                    },
                    child: Center(
                      child: Container(
                        color: AppThemeData.primaryColor,
                        width: PlatformInfo.isWeb
                            ? min(Get.width, 450)
                            : double.infinity,
                        height: double.infinity,
                        child: widget ?? const SizedBox(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
