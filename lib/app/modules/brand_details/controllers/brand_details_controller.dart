// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/models/activity.dart';
import 'package:blockie_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/models/issuer.dart';

class BrandDetailsController extends GetxController {
  final ProjectRepository projectRepository;

  BrandDetailsController({
    required this.projectRepository,
  });

  final issuer = Rxn<Issuer>();
  final activities = Rxn<List<Activity>>();
  final id = Get.parameters[BrandDetailsParameter.id] as String;

  @override
  void onReady() {
    super.onReady();
    getIssuerDetails();
  }

  void getIssuerDetails() async {
    issuer.value = await projectRepository.getIssuerInfo(id);
    getActivities();
  }

  void getActivities() async {
    final issuerValue = issuer.value;
    if (issuerValue == null) {
      return;
    }
    final paginatedActivities =
        await projectRepository.getBrandActivities(issuerValue.id);
    activities.value = paginatedActivities?.activities;
  }

  void goToActivity(String id) {
    final parameters = {ActivityParameter.id: id};
    Get.toNamed(Routes.activity, parameters: parameters);
  }
}

class BrandDetailsParameter {
  static const id = "id";
}
