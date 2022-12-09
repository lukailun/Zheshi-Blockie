// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:blockie_app/widgets/hide_keyboard_wrapper.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:statsfl/statsfl.dart';

// Project imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/models/app_theme_data.dart';
import 'package:blockie_app/data/models/environment.dart';
import 'package:blockie_app/data/models/platform_info.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/common_repository.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
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
        return HideKeyboardWrapper(
          child: StatsFl(
            isEnabled:
                Environment.isDevelopment && DebugService.to.showsFps.value,
            maxFps: 120,
            align: Alignment.bottomLeft,
            child: GetMaterialApp(
              title: DebugService.to.isDevTitle.value
                  ? Environment.appTitle
                  : Environment.appTitle.replaceAll('[DEV] ', ''),
              getPages: AppPages(
                accountRepository: accountRepository,
                commonRepository: commonRepository,
                profileRepository: profileRepository,
                projectRepository: projectRepository,
                projectsManagementRepository: projectsManagementRepository,
              ).routes,
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.activities,
              defaultTransition: Transition.cupertino,
              theme: ThemeData(
                appBarTheme: const AppBarTheme(elevation: 0),
                fontFamily: '--apple-system',
              ),
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: Material(
                    color: const Color(0xFFF0F2F5),
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
