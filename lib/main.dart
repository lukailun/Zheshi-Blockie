// Flutter imports:
import 'package:blockie_app/data/repositories/finance_repository.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/blockie_app.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/common_repository.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/debug_service.dart';
import 'package:blockie_app/services/local_assets_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_service.dart';
import 'package:blockie_app/utils/data_storage.dart';

void main() async {
  const fileName = String.fromEnvironment('ENV_FILE_NAME');
  await dotenv.load(fileName: fileName);
  WidgetsFlutterBinding.ensureInitialized();
  final remoteApi = BlockieApi(userTokenSupplier: () => DataStorage.getToken());
  final accountRepository = AccountRepository(remoteApi: remoteApi);
  final commonRepository = CommonRepository(remoteApi: remoteApi);
  final financeRepository = FinanceRepository(remoteApi: remoteApi);
  final profileRepository = ProfileRepository(remoteApi: remoteApi);
  final projectRepository = ProjectRepository(remoteApi: remoteApi);
  final projectsManagementRepository =
      ProjectsManagementRepository(remoteApi: remoteApi);
  _initServices(
    accountRepository: accountRepository,
    commonRepository: commonRepository,
    financeRepository: financeRepository,
    profileRepository: profileRepository,
    projectRepository: projectRepository,
    projectsManagementRepository: projectsManagementRepository,
  );
  runApp(
    BlockieApp(
      accountRepository: accountRepository,
      commonRepository: commonRepository,
      financeRepository: financeRepository,
      profileRepository: profileRepository,
      projectRepository: projectRepository,
      projectsManagementRepository: projectsManagementRepository,
    ),
  );
}

void _initServices({
  required AccountRepository accountRepository,
  required CommonRepository commonRepository,
  required FinanceRepository financeRepository,
  required ProfileRepository profileRepository,
  required ProjectRepository projectRepository,
  required ProjectsManagementRepository projectsManagementRepository,
}) {
  Get.put(AuthService(accountRepository: accountRepository));
  Get.put(AnyWebService());
  Get.put(WechatService(commonRepository: commonRepository));
  Get.put(LocalAssetsService());
  Get.put(DebugService());
}
