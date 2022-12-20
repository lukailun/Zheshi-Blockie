// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wechat_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatConfig _$WechatConfigFromJson(Map<String, dynamic> json) => WechatConfig(
      appId: json['appId'] as String,
      nonceString: json['nonceStr'] as String,
      timestamp: json['timestamp'] as int,
      signature: json['signature'] as String,
      apis:
          (json['jsApiList'] as List<dynamic>).map((e) => e as String).toList(),
      openTags: (json['openTagList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isDebug: json['debug'] as bool,
    );

Map<String, dynamic> _$WechatConfigToJson(WechatConfig instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'nonceStr': instance.nonceString,
      'timestamp': instance.timestamp,
      'signature': instance.signature,
      'jsApiList': instance.apis,
      'openTagList': instance.openTags,
      'debug': instance.isDebug,
    };
