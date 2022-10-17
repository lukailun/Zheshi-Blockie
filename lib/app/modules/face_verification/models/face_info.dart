// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'face_info.g.dart';

@JsonSerializable(explicitToJson: true)
class FaceInfo {
  @JsonKey(name: 'uid')
  String ID;
  @JsonKey(name: 'face_path')
  String path;

  FaceInfo({
    required this.ID,
    required this.path,
  });

  factory FaceInfo.fromJson(Map<String, dynamic> json) =>
      _$FaceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FaceInfoToJson(this);
}
