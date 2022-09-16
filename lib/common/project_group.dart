import 'package:blockie_app/common/project_info.dart';

class ProjectGroup {
  final String name;
  final String summary;
  final String description;
  final String uid;
  final List<ProjectInfo> projects;
  Map<String, dynamic>? json;

  ProjectGroup({
    required this.name,
    required this.summary,
    required this.description,
    required this.uid,
    required this.projects,
    this.json
  });

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
        projects: projects,
        json: json
    );
  }
}