// Package imports:
import 'package:blockie_app/models/video.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/nft_type.dart';
import 'package:blockie_app/app/modules/activity/models/project_status.dart';
import 'package:blockie_app/app/modules/activity/models/video_status.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/utils/date_time_utils.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'category_cn')
  final String category;
  @JsonKey(name: 'name')
  final String title;
  @JsonKey(name: 'cover_path')
  final String coverPath;
  @JsonKey(name: 'summary')
  final String summary;
  @JsonKey(name: 'started_at')
  final int startedTimestamp;
  @JsonKey(name: 'ended_at')
  final int endedTimestamp;
  @JsonKey(name: 'server_time')
  final int serverTimestamp;
  @JsonKey(name: 'nft_type')
  final int nftTypeValue;
  @JsonKey(name: 'is_open')
  final bool? isQualified;
  @JsonKey(name: 'mint_chances')
  final int? mintChances;
  @JsonKey(name: 'video')
  final Video? video;
  @JsonKey(name: 'preview_video')
  final Video? previewVideo;
  @JsonKey(name: 'video_process_status')
  final int? videoStatusValue;

  Project({
    required this.id,
    required this.category,
    required this.title,
    required this.coverPath,
    required this.summary,
    required this.startedTimestamp,
    required this.endedTimestamp,
    required this.serverTimestamp,
    required this.nftTypeValue,
    required this.isQualified,
    required this.mintChances,
    required this.video,
    required this.previewVideo,
    required this.videoStatusValue,
  });

  String? get coverUrl => coverPath.isNotEmpty ? coverPath.hostAdded : null;

  NftType get nftType =>
      NftType.values.firstWhere((it) => it.value == nftTypeValue);

  bool get isVideoNft => nftType == NftType.video;

  VideoStatus get videoStatus => videoStatusValue != null
      ? VideoStatus.values.firstWhere((it) => it.value == videoStatusValue)
      : VideoStatus.unknown;

  String? get startedTime => () {
        if (startedTimestamp <= 0) {
          return null;
        }
        return DateTimeUtils.dateTimeStringFromTimestamp(
          timestamp: startedTimestamp,
          dateFormatType: DateFormatType.YYYY_MM_DD_HH_MM_SS,
        );
      }();

  String? get endedTime => () {
        if (endedTimestamp <= 0) {
          return null;
        }
        return DateTimeUtils.dateTimeStringFromTimestamp(
          timestamp: endedTimestamp,
          dateFormatType: DateFormatType.YYYY_MM_DD_HH_MM_SS,
        );
      }();

  ProjectStatus get status => () {
        if (serverTimestamp < startedTimestamp) {
          return ProjectStatus.notStarted;
        }
        if (serverTimestamp > endedTimestamp) {
          return ProjectStatus.expired;
        }
        if (serverTimestamp >= startedTimestamp &&
            serverTimestamp <= endedTimestamp) {
          return ProjectStatus.ongoing;
        }
        return ProjectStatus.unknown;
      }();

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
