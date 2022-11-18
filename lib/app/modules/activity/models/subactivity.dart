// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/project.dart';
import 'package:blockie_app/app/modules/activity/models/subactivity_status.dart';
import 'package:blockie_app/models/subactivity_step.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/utils/date_time_utils.dart';

part 'subactivity.g.dart';

@JsonSerializable(explicitToJson: true)
class Subactivity {
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'started_at')
  final int startedTimestamp;
  @JsonKey(name: 'ended_at')
  final int endedTimestamp;
  @JsonKey(name: 'server_time')
  final int serverTimestamp;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'participants')
  final List<String> participantAvatarPaths;
  @JsonKey(name: 'participants_count')
  final int numberOfParticipants;
  @JsonKey(name: 'staff_qrcode')
  final String? staffQrCodePath;
  @JsonKey(name: 'missions')
  final List<SubactivityStep> steps;
  @JsonKey(name: 'rights')
  final List<Project> projects;

  Subactivity({
    required this.id,
    required this.startedTimestamp,
    required this.endedTimestamp,
    required this.serverTimestamp,
    required this.description,
    required this.participantAvatarPaths,
    required this.numberOfParticipants,
    required this.staffQrCodePath,
    required this.steps,
    required this.projects,
  });

  String? get startedTime => () {
        if (startedTimestamp <= 0) {
          return null;
        }
        return DateTimeUtils.dateTimeStringFromTimestamp(
          timestamp: startedTimestamp,
          dateFormatType: DateFormatType.YYYY_MM_DD_HH_MM,
        );
      }();

  String? get endedTime => () {
        if (endedTimestamp <= 0) {
          return null;
        }
        return DateTimeUtils.dateTimeStringFromTimestamp(
          timestamp: endedTimestamp,
          dateFormatType: DateFormatType.YYYY_MM_DD_HH_MM,
        );
      }();

  SubactivityStatus get status => () {
        if (serverTimestamp < startedTimestamp) {
          return SubactivityStatus.notStarted;
        }
        if (serverTimestamp > endedTimestamp) {
          return SubactivityStatus.expired;
        }
        if (serverTimestamp >= startedTimestamp &&
            serverTimestamp <= endedTimestamp) {
          return SubactivityStatus.ongoing;
        }
        return SubactivityStatus.unknown;
      }();

  List<String> get participantAvatarUrls =>
      participantAvatarPaths.map((it) => it.hostAdded).toList();

  String? get staffQrCodeUrl => (staffQrCodePath ?? '').isNotEmpty
      ? (staffQrCodePath ?? '').hostAdded
      : null;

  bool get allStepsCompleted => steps.every((it) => it.isCompleted);

  factory Subactivity.fromJson(Map<String, dynamic> json) =>
      _$SubactivityFromJson(json);

  Map<String, dynamic> toJson() => _$SubactivityToJson(this);
}
