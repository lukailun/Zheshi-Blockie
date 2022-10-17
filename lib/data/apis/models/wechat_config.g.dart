// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wechat_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatConfig _$WechatConfigFromJson(Map<String, dynamic> json) => WechatConfig(
      appID: json['appId'] as String,
      nonceString: json['nonceStr'] as String,
      timestamp: json['timestamp'] as int,
      signature: json['signature'] as String,
      APIs:
          (json['jsApiList'] as List<dynamic>).map((e) => e as String).toList(),
      isDebug: json['debug'] as bool,
    );
