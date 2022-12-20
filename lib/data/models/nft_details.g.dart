// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftDetails _$NftDetailsFromJson(Map<String, dynamic> json) => NftDetails(
      tokenId: json['token_id'] as String,
      mintedTimestamp: json['minted_at'] as int,
      coverPath: json['cover'] as String? ?? '',
      texturesValue: json['image'] ?? {},
      modelImages: (json['model_image'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map))
              .toList() ??
          [],
      modelPath: json['model'] as String? ?? '',
      videoPath: json['video'] as String? ?? '',
      nftType: $enumDecode(_$NftTypeEnumMap, json['type']),
      id: json['uid'] as String,
      subactivity: NftDetailsSubactivity.fromJson(
          json['activity'] as Map<String, dynamic>),
      benefit:
          NftDetailsBenefit.fromJson(json['right'] as Map<String, dynamic>),
      issuer: Issuer.fromJson(json['issuer'] as Map<String, dynamic>),
      userInfo: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
      unionTokenId: json['union_token_id'] as String,
      pasterType: $enumDecode(_$NftPasterTypeEnumMap, json['blockie_type']),
      souvenirs: (json['souvenirs'] as List<dynamic>?)
              ?.map(
                  (e) => NftDetailsSouvenir.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) =>
                  NftDetailsAttribute.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$NftDetailsToJson(NftDetails instance) =>
    <String, dynamic>{
      'token_id': instance.tokenId,
      'minted_at': instance.mintedTimestamp,
      'cover': instance.coverPath,
      'image': instance.texturesValue,
      'model_image': instance.modelImages,
      'model': instance.modelPath,
      'video': instance.videoPath,
      'type': _$NftTypeEnumMap[instance.nftType]!,
      'uid': instance.id,
      'activity': instance.subactivity.toJson(),
      'right': instance.benefit.toJson(),
      'issuer': instance.issuer.toJson(),
      'user': instance.userInfo.toJson(),
      'union_token_id': instance.unionTokenId,
      'blockie_type': _$NftPasterTypeEnumMap[instance.pasterType]!,
      'souvenirs': instance.souvenirs.map((e) => e.toJson()).toList(),
      'attributes': instance.attributes.map((e) => e.toJson()).toList(),
    };

const _$NftTypeEnumMap = {
  NftType.image: 1,
  NftType.blockie: 2,
  NftType.card: 3,
  NftType.model: 4,
};

const _$NftPasterTypeEnumMap = {
  NftPasterType.undefined: 0,
  NftPasterType.blockie: 1,
  NftPasterType.blockie2d: 2,
  NftPasterType.blockie3d: 3,
};

NftDetailsSubactivity _$NftDetailsSubactivityFromJson(
        Map<String, dynamic> json) =>
    NftDetailsSubactivity(
      shareTitle: json['share_title'] as String? ?? '',
      shareDescription: json['share_msg'] as String? ?? '',
      id: json['uid'] as String,
    );

Map<String, dynamic> _$NftDetailsSubactivityToJson(
        NftDetailsSubactivity instance) =>
    <String, dynamic>{
      'share_title': instance.shareTitle,
      'share_msg': instance.shareDescription,
      'uid': instance.id,
    };

NftDetailsBenefit _$NftDetailsBenefitFromJson(Map<String, dynamic> json) =>
    NftDetailsBenefit(
      name: json['name'] as String,
      description: json['description'] as String,
      walletAddress: json['contract'] as String,
      totalAmount: json['total_amount'] as int,
      id: json['uid'] as String,
    );

Map<String, dynamic> _$NftDetailsBenefitToJson(NftDetailsBenefit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'contract': instance.walletAddress,
      'total_amount': instance.totalAmount,
      'uid': instance.id,
    };

NftDetailsSouvenir _$NftDetailsSouvenirFromJson(Map<String, dynamic> json) =>
    NftDetailsSouvenir(
      id: json['uid'] as String,
      description: json['msg'] as String,
    );

Map<String, dynamic> _$NftDetailsSouvenirToJson(NftDetailsSouvenir instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'msg': instance.description,
    };

NftDetailsAttribute _$NftDetailsAttributeFromJson(Map<String, dynamic> json) =>
    NftDetailsAttribute(
      key: json['key'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$NftDetailsAttributeToJson(
        NftDetailsAttribute instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
