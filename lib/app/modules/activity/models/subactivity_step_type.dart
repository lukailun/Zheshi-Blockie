import 'package:json_annotation/json_annotation.dart';

enum SubactivityStepType {
  @JsonValue('login')
  login,
  @JsonValue('signup')
  registrationInfo,
  @JsonValue('finished_match')
  finish,
  @JsonValue('volunteer')
  volunteer;
}
