// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souvenir.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Souvenir _$SouvenirFromJson(Map<String, dynamic> json) => Souvenir(
      id: json['uid'] as String,
      name: json['name'] as String,
      isPunched: json['is_punched'] as bool,
      punchedAmount: json['punched_amount'] as int,
      totalAmount: json['total_amount'] as int,
    );

Map<String, dynamic> _$SouvenirToJson(Souvenir instance) => <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'is_punched': instance.isPunched,
      'punched_amount': instance.punchedAmount,
      'total_amount': instance.totalAmount,
    };
