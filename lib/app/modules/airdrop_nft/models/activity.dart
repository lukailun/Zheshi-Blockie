// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'activity.g.dart';

@JsonSerializable(explicitToJson: true)
class Activity {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'cover')
  String coverPath;
  @JsonKey(name: 'mint_status')
  bool hasMinted;

  @JsonKey(ignore: true)
  bool isSelected;

  Activity({
    required this.id,
    required this.name,
    required this.coverPath,
    required this.hasMinted,
    this.isSelected = false,
  });

  String get coverUrl => coverPath.hostAdded;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
