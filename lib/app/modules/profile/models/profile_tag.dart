// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'profile_tag.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileTag {
  @JsonKey(name: 'icon_path')
  final String iconPath;
  @JsonKey(name: 'name_cn')
  final String name;
  @JsonKey(name: 'name')
  final String id;

  ProfileTag({
    required this.iconPath,
    required this.name,
    required this.id,
  });

  String get iconUrl => iconPath.hostAdded;

  factory ProfileTag.fromJson(Map<String, dynamic> json) =>
      _$ProfileTagFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileTagToJson(this);
}
