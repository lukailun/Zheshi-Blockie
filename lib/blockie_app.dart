// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/widgets/hide_keyboard_wrapper.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
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
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BlockieApp extends StatelessWidget {
  final AccountRepository accountRepository;
  final CommonRepository commonRepository;
  final FinanceRepository financeRepository;
  final ProfileRepository profileRepository;
  final ProjectRepository projectRepository;
  final ProjectsManagementRepository projectsManagementRepository;

  const BlockieApp({
    super.key,
    required this.accountRepository,
    required this.commonRepository,
    required this.financeRepository,
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
            child: RefreshConfiguration(
              headerBuilder: () => CustomHeader(
                builder: (context, status) {
                  Widget body;
                  if (status == RefreshStatus.idle) {
                    body =
                        const Text('下拉刷新').fontSize(12).textColor(Colors.white);
                  } else if (status == RefreshStatus.refreshing) {
                    body = const SizedBox(
                      width: 20,
                      height: 20,
                      child: LoadingIndicator(),
                    );
                  } else if (status == RefreshStatus.failed) {
                    body =
                        const Text('刷新失败').fontSize(12).textColor(Colors.white);
                  } else if (status == RefreshStatus.canRefresh) {
                    body =
                        const Text('松手刷新').fontSize(12).textColor(Colors.white);
                  } else {
                    body = const SizedBox();
                  }
                  return SizedBox(
                    height: 40.0,
                    child: Center(child: body),
                  );
                },
              ),
              footerBuilder: () => CustomFooter(
                builder: (context, status) {
                  Widget body;
                  if (status == LoadStatus.idle) {
                    body =
                        const Text('上拉加载').fontSize(12).textColor(Colors.white);
                  } else if (status == LoadStatus.loading) {
                    body = const SizedBox(
                      width: 20,
                      height: 20,
                      child: LoadingIndicator(),
                    );
                  } else if (status == LoadStatus.failed) {
                    body =
                        const Text('加载失败').fontSize(12).textColor(Colors.white);
                  } else if (status == LoadStatus.canLoading) {
                    body =
                        const Text('加载更多').fontSize(12).textColor(Colors.white);
                  } else {
                    body = const Text('没有更多数据')
                        .fontSize(12)
                        .textColor(Colors.white);
                  }
                  return SizedBox(
                    height: 40.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: GetMaterialApp(
                title: DebugService.to.isDevTitle.value
                    ? Environment.appTitle
                    : Environment.appTitle.replaceAll('[DEV] ', ''),
                getPages: AppPages(
                  accountRepository: accountRepository,
                  commonRepository: commonRepository,
                  financeRepository: financeRepository,
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
          ),
        );
      },
    );
  }
}
