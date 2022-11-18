// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/video.dart';

part 'share_info.g.dart';

@JsonSerializable(explicitToJson: true)
class ShareInfo {
  @JsonKey(name: 'poster_path')
  String posterPath;
  @JsonKey(name: 'raw_path')
  String imagePath;
  @JsonKey(name: 'video')
  Video? video;

  ShareInfo({
    required this.posterPath,
    required this.imagePath,
    this.video,
  });

  String? get posterUrl => posterPath.isNotEmpty ? posterPath.hostAdded : null;

  String? get imageUrl => imagePath.isNotEmpty ? imagePath.hostAdded : null;

  factory ShareInfo.fromJson(Map<String, dynamic> json) =>
      _$ShareInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);
}
