// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareInfo _$ShareInfoFromJson(Map<String, dynamic> json) => ShareInfo(
      posterPath: json['poster_path'] as String,
      imagePath: json['raw_path'] as String,
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShareInfoToJson(ShareInfo instance) => <String, dynamic>{
      'poster_path': instance.posterPath,
      'raw_path': instance.imagePath,
      'video': instance.video?.toJson(),
    };
