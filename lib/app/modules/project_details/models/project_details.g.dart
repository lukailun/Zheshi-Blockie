// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDetails _$ProjectDetailsFromJson(Map<String, dynamic> json) =>
    ProjectDetails(
      name: json['name'] as String,
      summary: json['summary'] as String?,
      description: json['description'] as String,
      headerPath: json['bg_path'] as String,
      introduction: json['introduction'] as String,
      coverPath: json['cover_path'] as String,
      imagePaths:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      totalAmount: json['total_amount'] as int,
      startedTimestamp: json['started_at'] as int,
      endedTimestamp: json['ended_at'] as int,
      serverTimestamp: json['server_time'] as int,
      contract: json['contract'] as String,
      mintedAmount: json['minted_amount'] as int,
      heldAmount: json['holded_person'] as int,
      isQualified: json['is_open'] as bool?,
      isSubscribed: json['is_subscribed'] as bool?,
      mintChances: json['mint_chances'] as int?,
      userMintedAmount: json['user_minted_amount'] as int?,
      id: json['uid'] as String,
      issuer: Issuer.fromJson(json['issuer'] as Map<String, dynamic>),
      extraInfo: ProjectDetailsExtraInfo.fromJson(
          json['content'] as Map<String, dynamic>),
      activityId: json['group_uid'] as String,
      videoStatus: $enumDecodeNullable(
          _$VideoStatusEnumMap, json['video_process_status']),
      nftType: $enumDecode(_$NftTypeEnumMap, json['nft_type']),
      steps: (json['missions'] as List<dynamic>)
          .map((e) => SubactivityStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      needToClaimSouvenir: json['souvenir_available'] as bool,
    );

Map<String, dynamic> _$ProjectDetailsToJson(ProjectDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'summary': instance.summary,
      'description': instance.description,
      'bg_path': instance.headerPath,
      'introduction': instance.introduction,
      'cover_path': instance.coverPath,
      'images': instance.imagePaths,
      'total_amount': instance.totalAmount,
      'started_at': instance.startedTimestamp,
      'ended_at': instance.endedTimestamp,
      'server_time': instance.serverTimestamp,
      'contract': instance.contract,
      'minted_amount': instance.mintedAmount,
      'holded_person': instance.heldAmount,
      'is_open': instance.isQualified,
      'is_subscribed': instance.isSubscribed,
      'mint_chances': instance.mintChances,
      'user_minted_amount': instance.userMintedAmount,
      'uid': instance.id,
      'issuer': instance.issuer.toJson(),
      'content': instance.extraInfo.toJson(),
      'group_uid': instance.activityId,
      'video_process_status': _$VideoStatusEnumMap[instance.videoStatus],
      'nft_type': _$NftTypeEnumMap[instance.nftType]!,
      'missions': instance.steps.map((e) => e.toJson()).toList(),
      'souvenir_available': instance.needToClaimSouvenir,
    };

const _$VideoStatusEnumMap = {
  VideoStatus.unknown: 0,
  VideoStatus.unrecorded: 1,
  VideoStatus.inProcess: 2,
  VideoStatus.successful: 3,
  VideoStatus.failed: 4,
};

const _$NftTypeEnumMap = {
  NftType.basic: 1,
  NftType.video: 2,
  NftType.card: 3,
  NftType.kettleBell: 4,
};
