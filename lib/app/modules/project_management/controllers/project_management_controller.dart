// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/project_repository.dart';

class ProjectManagementController extends GetxController {
  final ProjectRepository repository;

  ProjectManagementController({required this.repository});
}
