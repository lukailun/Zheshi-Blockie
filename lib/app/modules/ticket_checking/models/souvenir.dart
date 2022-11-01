// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'souvenir.g.dart';

@JsonSerializable(explicitToJson: true)
class Souvenir {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'is_punched')
  bool isPunched;
  @JsonKey(name: 'punched_amount')
  int punchedAmount;
  @JsonKey(name: 'total_amount')
  int totalAmount;

  @JsonKey(ignore: true)
  bool isSelected;

  Souvenir({
    required this.id,
    required this.name,
    required this.isPunched,
    required this.punchedAmount,
    required this.totalAmount,
    this.isSelected = false,
  });

  factory Souvenir.fromJson(Map<String, dynamic> json) =>
      _$SouvenirFromJson(json);

  Map<String, dynamic> toJson() => _$SouvenirToJson(this);
}
