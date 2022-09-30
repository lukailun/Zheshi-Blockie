import 'package:blockie_app/app/modules/event/models/event_step.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  final String name;
  final String description;
  @JsonKey(name: 'uid')
  final String ID;
  @JsonKey(name: 'poster_components')
  final List<EventStep> steps;

  Event({
    required this.name,
    required this.description,
    required this.ID,
    required this.steps,
  });

  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}