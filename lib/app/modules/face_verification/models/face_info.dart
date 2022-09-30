import 'package:json_annotation/json_annotation.dart';

part 'face_info.g.dart';

@JsonSerializable(explicitToJson: true)
class FaceInfo {
  @JsonKey(name: 'face_path')
  String path;
  @JsonKey(name: 'uid')
  String ID;

  FaceInfo({
    required this.path,
    required this.ID,
  });

  factory FaceInfo.fromJson(Map<String, dynamic> json) =>
      _$FaceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FaceInfoToJson(this);
}
