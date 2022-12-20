// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'subactivity_preview.g.dart';

@JsonSerializable(explicitToJson: true)
class SubactivityPreview {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'uid')
  final String id;

  SubactivityPreview({
    required this.name,
    required this.id,
  });

  factory SubactivityPreview.fromJson(Map<String, dynamic> json) =>
      _$SubactivityPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$SubactivityPreviewToJson(this);
}
