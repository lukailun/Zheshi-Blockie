// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/projects_management/models/projects.dart';

part 'paginated_projects.g.dart';

@JsonSerializable(explicitToJson: true)
class PaginatedProjects {
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  @JsonKey(name: 'data')
  List<Projects> projectsList;

  PaginatedProjects({
    required this.nextPageUrl,
    required this.projectsList,
  });

  factory PaginatedProjects.fromJson(Map<String, dynamic> json) =>
      _$PaginatedProjectsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedProjectsToJson(this);
}
