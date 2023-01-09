// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wechat_pay_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatPayParameters _$WechatPayParametersFromJson(Map<String, dynamic> json) =>
    WechatPayParameters(
      timestamp: json['timeStamp'] as int,
      nonceString: json['nonceStr'] as String,
      package: json['package'] as String,
      signType: json['signType'] as String,
      paySign: json['paySign'] as String,
    );

Map<String, dynamic> _$WechatPayParametersToJson(
        WechatPayParameters instance) =>
    <String, dynamic>{
      'timeStamp': instance.timestamp,
      'nonceStr': instance.nonceString,
      'package': instance.package,
      'signType': instance.signType,
      'paySign': instance.paySign,
    };
