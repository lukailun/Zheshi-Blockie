import 'package:json_annotation/json_annotation.dart';

enum NftType {
  @JsonValue(1)
  basic,
  @JsonValue(2)
  video,
  @JsonValue(3)
  card,
  @JsonValue(4)
  kettleBell;
}
