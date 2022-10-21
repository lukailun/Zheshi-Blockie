// Package imports:
import 'package:blockie_app/app/modules/project_details/models/project_status.dart';
import 'package:blockie_app/utils/date_time_utils.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:blockie_app/app/modules/project_details/models/mint_status.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details_item.dart';
import 'package:blockie_app/data/apis/models/issuer.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/auth_service.dart';

part 'project_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectDetails {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'summary')
  final String summary;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'introduction')
  final String introduction;
  @JsonKey(name: 'cover')
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
  @JsonKey(name: 'is_open')
  final bool? isQualified;
  @JsonKey(name: 'is_subscribed')
  final bool? isSubscribed;
  @JsonKey(name: 'mint_chances')
  final int? mintChances;
  @JsonKey(name: 'user_minted_amount')
  final int? userMintedAmount;
  @JsonKey(name: 'uid')
  final String id;
  @JsonKey(name: 'issuer')
  final Issuer issuer;

  const ProjectDetails({
    required this.name,
    required this.summary,
    required this.description,
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
  });

  String get coverUrl => coverPath.hostAdded;

  String? get startedTime => () {
        if (startedTimestamp <= 0) {
          return null;
        }
        return DateTimeUtils.dateTimeStringFromTimestamp(startedTimestamp);
      }();

  String? get endedTime => () {
        if (endedTimestamp <= 0) {
          return null;
        }
        return DateTimeUtils.dateTimeStringFromTimestamp(endedTimestamp);
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

  List<String> get imageUrls => imagePaths.map((it) => it.hostAdded).toList();

  factory ProjectDetails.fromJson(Map<String, dynamic> json) =>
      _$ProjectDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDetailsToJson(this);
}

extension ProjectDetailsExtension on ProjectDetails {
  List<ProjectDetailsItem> get items => [
        ProjectDetailsItem(title: '发行总量', content: '$totalAmount'),
        ProjectDetailsItem(title: '已铸造', content: '$mintedAmount'),
        ProjectDetailsItem(title: '持有者', content: '$heldAmount'),
        ProjectDetailsItem(title: '申领规则&玩法介绍', content: introduction),
        ProjectDetailsItem(title: '铸造开始时间', content: startedTime ?? ''),
        ProjectDetailsItem(title: '铸造结束时间', content: endedTime ?? ''),
        ProjectDetailsItem(
            title: '合约地址', content: contract, ellipsized: true, copyable: true),
      ];

  MintStatus mintStatus({required bool isMinting}) {
    if (!AuthService.to.isLoggedIn) {
      return MintStatus.notLogin;
    }
    if (isMinting) {
      return MintStatus.minting;
    }
    if (!(isQualified ?? false)) {
      return MintStatus.unqualified;
    }
    if ((mintChances ?? 0) <= 0) {
      return MintStatus.unqualified;
    }
    return MintStatus.mintable;
  }

  String mintHint({required bool isMinting}) {
    if (mintStatus(isMinting: isMinting) == MintStatus.notLogin) {
      return '请登录以获取你的铸造资格';
    }
    if (mintStatus(isMinting: isMinting) == MintStatus.unqualified) {
      return '未获得铸造资格';
    }
    if (userMintedAmount == 0) {
      return '剩余 $mintChances 次铸造机会';
    }
    return '已铸造 $userMintedAmount 次，剩余 $mintChances 次铸造机会';
  }
}
