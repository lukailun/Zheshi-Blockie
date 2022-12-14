// Package imports:
import 'package:blockie_app/app/routes/app_router.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/add_whitelist/controllers/add_whitelist_controller.dart';
import 'package:blockie_app/app/modules/airdrop_nft/controllers/airdrop_nft_controller.dart';
import 'package:blockie_app/app/modules/hold_verification/controllers/hold_verification_controller.dart';
import 'package:blockie_app/app/modules/projects_management/models/project.dart';
import 'package:blockie_app/app/modules/ticket_checking/controllers/ticket_checking_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
import 'package:blockie_app/widgets/projects_management_dialog.dart';

part 'projects_management_controller_router.dart';

class ProjectsManagementController extends GetxController {
  final ProjectsManagementRepository repository;

  ProjectsManagementController({required this.repository});

  final id = Get.parameters[ProjectsManagementParameter.id] ?? '';
  final name = Get.parameters[ProjectsManagementParameter.name] ?? '';
  final projects = Rxn<List<Project>>();

  @override
  void onReady() {
    super.onReady();
    getManagedProjects();
  }

  void getManagedProjects() async {
    projects.value = await repository.getManagedProjects(id: id);
  }
}

class ProjectsManagementParameter {
  static const id = 'id';
  static const name = 'name';
}
