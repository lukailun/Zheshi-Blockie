import 'package:blockie_app/common/project_group.dart';

class ProjectGroupLoadInfo{
  final String? nextPageUrl;
  final List<ProjectGroup> projectGroups;

  const ProjectGroupLoadInfo({
    required this.nextPageUrl,
    required this.projectGroups
  });

}