// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/nft_type.dart';
import 'package:blockie_app/app/modules/activity/models/video_status.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/models/project_status.dart';
import 'package:blockie_app/models/video.dart';
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
  @JsonKey(name: 'started_at')
  final int startedTimestamp;
  @JsonKey(name: 'ended_at')
  final int endedTimestamp;
  @JsonKey(name: 'server_time')
  final int serverTimestamp;
  @JsonKey(name: 'nft_type')
  final NftType nftType;
  @JsonKey(name: 'is_open', defaultValue: false)
  final bool isQualified;
  @JsonKey(name: 'mint_chances', defaultValue: 0)
  final int mintChances;
  @JsonKey(name: 'video')
  final Video? video;
  @JsonKey(name: 'preview_video')
  final Video? previewVideo;
  @JsonKey(name: 'video_process_status')
  final VideoStatus? videoStatus;
  @JsonKey(name: 'souvenir_available')
  final bool needToClaimSouvenir;

  Project({
    required this.id,
    required this.category,
    required this.title,
    required this.coverPath,
    required this.startedTimestamp,
    required this.endedTimestamp,
    required this.serverTimestamp,
    required this.nftType,
    required this.isQualified,
    required this.mintChances,
    required this.video,
    required this.previewVideo,
    required this.videoStatus,
    required this.needToClaimSouvenir,
  });

  String? get coverUrl => coverPath.isNotEmpty ? coverPath.hostAdded : null;

  bool get isVideoNft => nftType == NftType.video;

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
