// Package imports:
import 'package:json_annotation/json_annotation.dart';

enum SubactivityStepType {
  @JsonValue('login')
  login,
  @JsonValue('signup')
  register,
  @JsonValue('finished_match')
  finish,
  @JsonValue('volunteer')
  volunteer,
  @JsonValue('manual_finish')
  submitToFinish,
  @JsonValue('paid')
  pay;
}
