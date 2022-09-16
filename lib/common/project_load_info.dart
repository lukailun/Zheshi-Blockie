import 'package:blockie_app/common/project_info.dart';

class ProjectLoadInfo{
  final String? nextPageUrl;
  final List<ProjectInfo> projects;

  const ProjectLoadInfo({
    required this.nextPageUrl,
    required this.projects
  });

}