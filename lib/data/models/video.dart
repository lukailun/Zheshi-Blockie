// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'video.g.dart';

@JsonSerializable(explicitToJson: true)
class Video {
  @JsonKey(name: 'video_path')
  String? path;
  @JsonKey(name: 'cover_path')
  String? posterPath;

  Video({
    required this.path,
    required this.posterPath,
  });

  String? get url => (path ?? '').isNotEmpty ? (path ?? '').hostAdded : null;

  String? get posterUrl =>
      (posterPath ?? '').isNotEmpty ? (posterPath ?? '').hostAdded : null;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
