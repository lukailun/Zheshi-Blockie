// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'cover_path')
  String? coverPath;

  Project({
    required this.id,
    required this.name,
    required this.coverPath,
  });

  String? get coverUrl =>
      (coverPath ?? '').isNotEmpty ? (coverPath ?? '').hostAdded : null;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
