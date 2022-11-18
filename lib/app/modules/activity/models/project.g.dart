// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['uid'] as String,
      category: json['category_cn'] as String,
      title: json['name'] as String,
      coverPath: json['cover_path'] as String,
      summary: json['summary'] as String,
      startedTimestamp: json['started_at'] as int,
      endedTimestamp: json['ended_at'] as int,
      serverTimestamp: json['server_time'] as int,
      nftTypeValue: json['nft_type'] as int,
      isQualified: json['is_open'] as bool?,
      mintChances: json['mint_chances'] as int?,
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      previewVideo: json['preview_video'] == null
          ? null
          : Video.fromJson(json['preview_video'] as Map<String, dynamic>),
      videoStatusValue: json['video_process_status'] as int?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'uid': instance.id,
      'category_cn': instance.category,
      'name': instance.title,
      'cover_path': instance.coverPath,
      'summary': instance.summary,
      'started_at': instance.startedTimestamp,
      'ended_at': instance.endedTimestamp,
      'server_time': instance.serverTimestamp,
      'nft_type': instance.nftTypeValue,
      'is_open': instance.isQualified,
      'mint_chances': instance.mintChances,
      'video': instance.video?.toJson(),
      'preview_video': instance.previewVideo?.toJson(),
      'video_process_status': instance.videoStatusValue,
    };
