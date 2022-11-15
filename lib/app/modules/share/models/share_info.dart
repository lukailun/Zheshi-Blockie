// Package imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'share_info.g.dart';

@JsonSerializable(explicitToJson: true)
class ShareInfo {
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'raw_path')
  String imagePath;
  @JsonKey(name: 'video_path')
  String? videoPath;

  ShareInfo({
    required this.posterPath,
    required this.imagePath,
    this.videoPath,
  });

  String? get posterUrl => posterPath.isNotEmpty ? posterPath.hostAdded : null;

  String? get imageUrl => imagePath.isNotEmpty ? imagePath.hostAdded : null;

  String? get videoUrl =>
      (videoPath ?? '').isNotEmpty ? (videoPath ?? '').hostAdded : null;

  factory ShareInfo.fromJson(Map<String, dynamic> json) =>
      _$ShareInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);
}
