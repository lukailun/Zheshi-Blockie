// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/models/video_status.dart';
import 'package:blockie_app/app/modules/project_details/models/mint_rule.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details_extra_info.dart';
import 'package:blockie_app/data/models/basic_details_card_item.dart';
import 'package:blockie_app/data/models/issuer.dart';
import 'package:blockie_app/data/models/nft_paster_type.dart';
import 'package:blockie_app/data/models/nft_type.dart';
import 'package:blockie_app/data/models/project_status.dart';
import 'package:blockie_app/data/models/subactivity_step.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/utils/date_time_utils.dart';

part 'project_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectDetails {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'summary', defaultValue: '')
  final String summary;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'bg_path')
  final String headerPath;
  @JsonKey(name: 'introduction')
  final String introduction;
  @JsonKey(name: 'cover_path')
  final String coverPath;
  @JsonKey(name: 'images')
  final List<String> imagePaths;
  @JsonKey(name: 'total_amount')
  final int totalAmount;
  @JsonKey(name: 'started_at')
  final int startedTimestamp;
  @JsonKey(name: 'ended_at')
  final int endedTimestamp;
  @JsonKey(name: 'server_time')
  final int serverTimestamp;
  @JsonKey(name: 'contract')
  final String contract;
  @JsonKey(name: 'minted_amount')
  final int mintedAmount;
  @JsonKey(name: 'holded_person')
  final int heldAmount;
  @JsonKey(name: 'is_open', defaultValue: false)
  final bool isQualified;
  @JsonKey(name: 'is_subscribed', defaultValue: false)
  final bool isSubscribed;
  @JsonKey(name: 'mint_chances', defaultValue: 0)
  final int mintChances;
  @JsonKey(name: 'user_minted_amount', defaultValue: 0)
  final int userMintedAmount;
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'issuer')
  final Issuer issuer;
  @JsonKey(name: 'content')
  final ProjectDetailsExtraInfo extraInfo;
  @JsonKey(name: 'group_uid')
  final String activityId;
  @JsonKey(name: 'video_process_status')
  final VideoStatus? videoStatus;
  @JsonKey(name: 'nft_type')
  final NftType nftType;
  @JsonKey(name: 'missions')
  final List<SubactivityStep> steps;
  @JsonKey(name: 'souvenir_available')
  final bool needToClaimSouvenir;
  @JsonKey(name: 'blockie_type')
  final NftPasterType pasterType;

  const ProjectDetails({
    required this.name,
    required this.summary,
    required this.description,
    required this.headerPath,
    required this.introduction,
    required this.coverPath,
    required this.imagePaths,
    required this.totalAmount,
    required this.startedTimestamp,
    required this.endedTimestamp,
    required this.serverTimestamp,
    required this.contract,
    required this.mintedAmount,
    required this.heldAmount,
    required this.isQualified,
    required this.isSubscribed,
    required this.mintChances,
    required this.userMintedAmount,
    required this.id,
    required this.issuer,
    required this.extraInfo,
    required this.activityId,
    required this.videoStatus,
    required this.nftType,
    required this.steps,
    required this.needToClaimSouvenir,
    required this.pasterType,
  });

  String get coverUrl => coverPath.hostAdded;

  String get headerUrl => headerPath.hostAdded;

  List<String> get imageUrls => imagePaths.map((it) => it.hostAdded).toList();

  bool get isBlockieNft => nftType == NftType.blockie;

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

  MintRule? get mintRule => () {
        final ruleInfo = extraInfo.ruleInfo;
        if (ruleInfo == null) {
          return null;
        }
        if (ruleInfo.geometry != null) {
          return MintRule.distance;
        }
        if (ruleInfo.checkCode != null) {
          return MintRule.checkCode;
        }
        return null;
      }();

  bool get allStepsCompleted => steps.every((it) => it.isCompleted);

  factory ProjectDetails.fromJson(Map<String, dynamic> json) =>
      _$ProjectDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDetailsToJson(this);
}

extension ProjectDetailsExtension on ProjectDetails {
  List<BasicDetailsCardItem> get items => [
        BasicDetailsCardItem(title: '总发行量', content: '$totalAmount'),
        BasicDetailsCardItem(title: '已铸造', content: '$mintedAmount'),
        BasicDetailsCardItem(
            title: '合约地址', content: contract, ellipsized: true, copyable: true),
        const BasicDetailsCardItem(title: '链', content: 'Conflux'),
      ];
}
