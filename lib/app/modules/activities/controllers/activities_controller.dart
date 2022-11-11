// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/models/activity.dart';
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class ActivitiesController extends GetxController {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;

  ActivitiesController({
    required this.accountRepository,
    required this.projectRepository,
  });

  final activities = Rxn<List<Activity>>();
  final user = AuthService.to.user;

  @override
  void onReady() {
    super.onReady();
    _getActivities();
    getUser();
  }

  void _getActivities() async {
    final paginatedActivities = await projectRepository.getActivities();
    activities.value = paginatedActivities?.activities;
  }

  void goToActivity(GetDelegate delegate, String id) {
    final parameters = {ActivityParameter.id: id};
    Get.toNamed(Routes.activity, parameters: parameters);
  }

  void goToBrand(String id) {
    final parameters = {'issuerUid': id};
    Get.toNamed(Routes.brand, parameters: parameters);
  }

  void avatarOnTap() {
    final userValue = user.value;
    if (userValue == null) {
      return _showLicenseDialog();
    }
    final parameters = {ProfileParameter.id: userValue.id};
    Get.toNamed(Routes.profile, parameters: parameters);
  }

  void _showLicenseDialog() {
    Get.licenseDialog(onLoginSuccess: () {
      MessageToast.showMessage("登录成功");
      getUser();
    });
  }

  void getUser() async {
    if ((DataStorage.getToken() ?? '').isNotEmpty) {
      final user = await accountRepository.getUser();
      AuthService.to.user.value = user;
      AuthService.to.login();
    } else {
      AuthService.to.user.value = null;
      AuthService.to.logout();
    }
  }
}
