// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/event/models/event_step.dart';

part 'event_action_info.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class EventActionInfo {
  @JsonKey(name: 'activity_uid')
  final String ID;
  @JsonKey(name: 'action')
  final String actionValue;

  EventActionInfo({
    required this.ID,
    required this.actionValue,
  });

  EventAction get action =>
      EventAction.values.firstWhere((it) => it.value == actionValue);

  factory EventActionInfo.fromJson(Map<String, dynamic> json) =>
      _$EventActionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EventActionInfoToJson(this);
}

enum EventAction {
  login("login"),
  signUp("signup"),
  mint("mint");

  const EventAction(this.value);

  final String value;
}
