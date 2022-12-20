// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mint_rule_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MintRuleInfo _$MintRuleInfoFromJson(Map<String, dynamic> json) => MintRuleInfo(
      geometry: json['pos'] == null
          ? null
          : MintGeometry.fromJson(json['pos'] as Map<String, dynamic>),
      checkCode: json['mint_code'] as String?,
    );

Map<String, dynamic> _$MintRuleInfoToJson(MintRuleInfo instance) =>
    <String, dynamic>{
      'pos': instance.geometry?.toJson(),
      'mint_code': instance.checkCode,
    };
