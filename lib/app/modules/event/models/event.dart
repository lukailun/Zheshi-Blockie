// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/event/models/event_step.dart';
import 'package:blockie_app/app/modules/event/models/issuer.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  final String name;
  final String description;
  @JsonKey(name: 'uid')
  final String ID;
  @JsonKey(name: 'poster_components')
  final List<EventStep> steps;
  final Issuer issuer;

  Event({
    required this.name,
    required this.description,
    required this.ID,
    required this.steps,
    required this.issuer,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
