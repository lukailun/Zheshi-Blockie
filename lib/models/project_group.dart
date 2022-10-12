import 'package:blockie_app/models/project_info.dart';

class ProjectGroup {
  final String name;
  final String summary;
  final String description;
  final String uid;
  final int type; // 1 == single project, 2 == group
  final List<ProjectInfo> projects;

  ProjectGroup(
      {required this.name,
      required this.summary,
      required this.description,
      required this.uid,
      required this.type,
      required this.projects});

  factory ProjectGroup.fromJson(Map<String, dynamic> json) {
    List<ProjectInfo> projects = [];
    for (var project in json['activities']) {
      project['issuer'] = json['issuer'];
      projects.add(ProjectInfo.fromJson(project));
    }
    return ProjectGroup(
        name: json['name'],
        summary: json['summary'],
        description: json['description'],
        uid: json['uid'],
        type: json['type'],
        projects: projects);
  }
}
