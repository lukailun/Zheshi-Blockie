// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'profile_label.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileLabel {
  @JsonKey(name: 'icon_path')
  final String iconPath;
  @JsonKey(name: 'name_cn')
  final String name;
  @JsonKey(name: 'uid')
  final String id;

  ProfileLabel({
    required this.iconPath,
    required this.name,
    required this.id,
  });

  String get iconUrl => iconPath.hostAdded;

  factory ProfileLabel.fromJson(Map<String, dynamic> json) =>
      _$ProfileLabelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileLabelToJson(this);
}
