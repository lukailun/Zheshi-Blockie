// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'activity_action_info.g.dart';

@JsonSerializable(explicitToJson: true)
class ActivityActionInfo {
  @JsonKey(name: 'activity_uid')
  final String? id;
  @JsonKey(name: 'action')
  final String actionValue;

  ActivityActionInfo({
    required this.id,
    required this.actionValue,
  });

  ActivityAction get action =>
      ActivityAction.values.firstWhere((it) => it.value == actionValue);

  factory ActivityActionInfo.fromJson(Map<String, dynamic> json) =>
      _$ActivityActionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityActionInfoToJson(this);
}

enum ActivityAction {
  login("login"),
  signUp("signup"),
  mint("mint");

  const ActivityAction(this.value);

  final String value;
}
