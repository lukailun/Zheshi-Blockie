// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'share_info.g.dart';

@JsonSerializable(explicitToJson: true)
class ShareInfo {
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'raw_path')
  String path;
  @JsonKey(name: 'video_path')
  String? videoPath;

  ShareInfo({
    required this.posterPath,
    required this.path,
    this.videoPath,
  });

  factory ShareInfo.fromJson(Map<String, dynamic> json) =>
      _$ShareInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);
}
