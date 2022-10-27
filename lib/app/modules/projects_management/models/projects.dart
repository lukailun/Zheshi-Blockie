// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/models/project.dart';
import 'package:blockie_app/app/modules/projects_management/models/projects_type.dart';
import 'package:blockie_app/data/apis/models/issuer.dart';

part 'projects.g.dart';

@JsonSerializable(explicitToJson: true)
class Projects {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'summary')
  String summary;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'type')
  int typeValue;
  @JsonKey(name: 'activities')
  List<Project> projects;
  @JsonKey(name: 'issuer')
  Issuer issuer;

  Projects({
    required this.id,
    required this.name,
    required this.summary,
    required this.description,
    required this.typeValue,
    required this.projects,
    required this.issuer,
  });

  ProjectsType get type =>
      typeValue == 2 ? ProjectsType.activity : ProjectsType.project;

  factory Projects.fromJson(Map<String, dynamic> json) =>
      _$ProjectsFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsToJson(this);
}
