// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareInfo _$ShareInfoFromJson(Map<String, dynamic> json) => ShareInfo(
      posterPath: json['poster_path'] as String,
      path: json['raw_path'] as String,
    );

Map<String, dynamic> _$ShareInfoToJson(ShareInfo instance) => <String, dynamic>{
      'poster_path': instance.posterPath,
      'raw_path': instance.path,
    };
