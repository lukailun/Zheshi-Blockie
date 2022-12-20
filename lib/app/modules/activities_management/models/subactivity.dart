// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

part 'subactivity.g.dart';

@JsonSerializable(explicitToJson: true)
class Subactivity {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'summary')
  final String? summary;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'cover')
  final String coverPath;
  @JsonKey(name: 'contract')
  final String? contract;
  @JsonKey(name: 'total_amount')
  final int? totalAmount;

  Subactivity({
    required this.name,
    required this.summary,
    required this.description,
    required this.id,
    required this.coverPath,
    required this.contract,
    required this.totalAmount,
  });

  String? get coverUrl => coverPath.isNotEmpty ? coverPath.hostAdded : null;

  factory Subactivity.fromJson(Map<String, dynamic> json) =>
      _$SubactivityFromJson(json);

  Map<String, dynamic> toJson() => _$SubactivityToJson(this);
}
