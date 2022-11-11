import 'package:blockie_app/data/apis/models/issuer.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';

import '../../activities/models/activity.dart';

class BrandDetailsController extends GetxController {
  final ProjectRepository projectRepository;

  BrandDetailsController({
    required this.projectRepository,
  });

  final issuer = Rxn<Issuer>();
  final activities = Rxn<List<Activity>>();

  @override
  void onReady() {
    super.onReady();
    _getActivities();
  }

  void _getActivities() async {
    final issuerValue = issuer.value;
    if (issuerValue == null) {
      return;
    }
    final paginatedActivities =
        await projectRepository.getBrandActivities(issuerValue.id);
    activities.value = paginatedActivities?.activities;
  }
}
