// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/data/models/issuer.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/utils/date_time_utils.dart';

part 'activity.g.dart';

@JsonSerializable(explicitToJson: true)
class Activity {
  @JsonKey(name: 'uid')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'address')
  String location;
  @JsonKey(name: 'is_online')
  bool isOnline;
  @JsonKey(name: 'cover_path')
  String coverPath;
  @JsonKey(name: 'rights')
  List<String> benefits;
  @JsonKey(name: 'issuer')
  Issuer issuer;
  @JsonKey(name: 'started_at')
  final int startedTimestamp;

  Activity({
    required this.id,
    required this.name,
    required this.location,
    required this.isOnline,
    required this.coverPath,
    required this.benefits,
    required this.issuer,
    required this.startedTimestamp,
  });

  String? get coverUrl => coverPath.isNotEmpty ? coverPath.hostAdded : null;

  String? get startedTime {
    if (startedTimestamp <= 0) {
      return null;
    }
    return DateTimeUtils.dateTimeStringFromTimestamp(
      timestamp: startedTimestamp,
      dateFormatType: DateFormatType.MM_DD_EEE_HH_MM,
    );
  }

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
