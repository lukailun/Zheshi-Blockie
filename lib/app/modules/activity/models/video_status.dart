import 'package:json_annotation/json_annotation.dart';

enum VideoStatus {
  @JsonValue(0)
  unknown,
  @JsonValue(1)
  unrecorded,
  @JsonValue(2)
  inProcess,
  @JsonValue(3)
  successful,
  @JsonValue(4)
  failed;
}
