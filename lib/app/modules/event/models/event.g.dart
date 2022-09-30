// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      name: json['name'] as String,
      description: json['description'] as String,
      ID: json['uid'] as String,
      steps: (json['poster_components'] as List<dynamic>)
          .map((e) => EventStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'uid': instance.ID,
      'poster_components': instance.steps.map((e) => e.toJson()).toList(),
    };
