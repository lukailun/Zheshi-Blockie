// Project imports:
import 'package:blockie_app/models/project_group.dart';

class ProjectGroupLoadInfo {
  final String? nextPageUrl;
  final List<ProjectGroup> projectGroups;

  const ProjectGroupLoadInfo(
      {required this.nextPageUrl, required this.projectGroups});
}
