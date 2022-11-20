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
      startedTimestamp: json['started_at'] as int,
      endedTimestamp: json['ended_at'] as int,
      serverTimestamp: json['server_time'] as int,
      nftType: $enumDecode(_$NftTypeEnumMap, json['nft_type']),
      isQualified: json['is_open'] as bool? ?? false,
      mintChances: json['mint_chances'] as int? ?? 0,
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      previewVideo: json['preview_video'] == null
          ? null
          : Video.fromJson(json['preview_video'] as Map<String, dynamic>),
      videoStatus: $enumDecodeNullable(
          _$VideoStatusEnumMap, json['video_process_status']),
      needToClaimSouvenir: json['souvenir_available'] as bool,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'uid': instance.id,
      'category_cn': instance.category,
      'name': instance.title,
      'cover_path': instance.coverPath,
      'started_at': instance.startedTimestamp,
      'ended_at': instance.endedTimestamp,
      'server_time': instance.serverTimestamp,
      'nft_type': _$NftTypeEnumMap[instance.nftType]!,
      'is_open': instance.isQualified,
      'mint_chances': instance.mintChances,
      'video': instance.video?.toJson(),
      'preview_video': instance.previewVideo?.toJson(),
      'video_process_status': _$VideoStatusEnumMap[instance.videoStatus],
      'souvenir_available': instance.needToClaimSouvenir,
    };

const _$NftTypeEnumMap = {
  NftType.basic: 1,
  NftType.video: 2,
  NftType.card: 3,
  NftType.kettleBell: 4,
};

const _$VideoStatusEnumMap = {
  VideoStatus.unknown: 0,
  VideoStatus.unrecorded: 1,
  VideoStatus.inProcess: 2,
  VideoStatus.successful: 3,
  VideoStatus.failed: 4,
};
