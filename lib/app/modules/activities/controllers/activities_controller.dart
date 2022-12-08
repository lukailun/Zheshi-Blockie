// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/models/activity.dart';
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/app/modules/brand_details/controllers/brand_details_controller.dart';
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'activities_controller_router.dart';

class ActivitiesController extends GetxController {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;

  ActivitiesController({
    required this.accountRepository,
    required this.projectRepository,
  });

  final activities = Rxn<List<Activity>>();
  final user = AuthService.to.userInfo;

  @override
  void onReady() {
    super.onReady();
    getActivities();
    getUserInfo();
  }

  void getActivities() async {
    final paginatedActivities = await projectRepository.getActivities();
    activities.value = paginatedActivities?.activities;
  }

  void avatarOnTap() {
    final userValue = user.value;
    if (userValue == null) {
      return openLicenseDialog();
    }
    goToProfile();
  }

  void getUserInfo() async {
    if ((DataStorage.getToken() ?? '').isNotEmpty) {
      final user = await accountRepository.getUserInfo();
      AuthService.to.userInfo.value = user;
      AuthService.to.login();
    } else {
      AuthService.to.userInfo.value = null;
      AuthService.to.logout();
    }
  }
}
