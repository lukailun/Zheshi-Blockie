// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'date.g.dart';

@JsonSerializable(explicitToJson: true)
class Date {
  @JsonKey(name: 'year')
  int year;
  @JsonKey(name: 'month')
  int month;
  @JsonKey(name: 'day')
  int day;

  Date({
    required this.year,
    required this.month,
    required this.day,
  });

  String get dateString => '$year-$month-$day';

  String get constellation => DateTime(year, month, day).constellation;

  String get toJsonString => jsonEncode(this);

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);

  Map<String, dynamic> toJson() => _$DateToJson(this);
}
