// Package imports:
import 'package:json_annotation/json_annotation.dart';

enum ActivityType {
  @JsonValue(2)
  activity,
  @JsonValue(1)
  subactivity,
}
