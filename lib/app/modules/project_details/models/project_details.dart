// Project imports:
import 'package:blockie_app/app/modules/project_details/models/mint_status.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details_item.dart';
import 'package:blockie_app/models/issuer_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import '../../../../models/global.dart';

class ProjectDetails {
  final String cover;
  final String name;
  final String summary;
  final String description;
  final String contract;
  final List<String> images;
  final bool? isOpen;
  final bool? isSubscribed;
  final int? mintChances;
  final int? userMintedAmount;
  final int totalAmount;
  final int mintedAmount;
  final int holdPersonAmount;
  final String startedTime;
  final String endedTime;
  final String uid;
  final IssuerInfo issuer;

  const ProjectDetails(
      {required this.cover,
      required this.name,
      required this.summary,
      required this.description,
      required this.contract,
      required this.images,
      required this.isOpen,
      required this.isSubscribed,
      required this.mintChances,
      required this.userMintedAmount,
      required this.totalAmount,
      required this.mintedAmount,
      required this.holdPersonAmount,
      required this.startedTime,
      required this.endedTime,
      required this.uid,
      required this.issuer});

  List<ProjectDetailsItem> get items => [
        ProjectDetailsItem(title: '发行总量', content: '$totalAmount'),
        ProjectDetailsItem(title: '已铸造', content: '$mintedAmount'),
        ProjectDetailsItem(title: '持有者', content: '$holdPersonAmount'),
        ProjectDetailsItem(
            title: '申领规则&玩法介绍', content: '购买线下实体并使用手机号登录，即可获得铸造资格'),
        ProjectDetailsItem(title: '铸造开始时间', content: startedTime),
        ProjectDetailsItem(title: '铸造结束时间', content: endedTime),
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
    if (!(isOpen ?? false)) {
      return MintStatus.unopened;
    }
    if ((mintChances ?? 0) <= 0) {
      return MintStatus.unqualified;
    }
    return MintStatus.mintable;
  }

  String get mintHint => () {
        if (mintStatus == MintStatus.notLogin) {
          return '请登陆后查看铸造资格';
        }
        if (mintStatus == MintStatus.unqualified) {
          return '请登陆后查看铸造资格';
        }
        if (userMintedAmount == 0) {
          return '剩余 $mintChances 次铸造机会';
        }
        return '已铸造 $userMintedAmount 次，剩余 $mintChances 次铸造机会';
      }();

  factory ProjectDetails.fromJson(Map<String, dynamic> json) {
    List<String> images = json['images']
        .map<String>((e) => Global.assetHost + e.toString())
        .toList();
    return ProjectDetails(
        cover: Global.assetHost + json['cover'],
        name: json['name'],
        summary: json['summary'],
        description: json['description'],
        contract: json['contract'],
        images: images,
        isOpen: json['is_open'],
        isSubscribed: json['is_subscribed'],
        mintChances: json['mint_chances'],
        userMintedAmount: json['user_minted_amount'],
        totalAmount: json['total_amount'],
        mintedAmount: json['minted_amount'],
        holdPersonAmount: json['holded_person'],
        startedTime: json['started_at'],
        endedTime: json['ended_at'],
        uid: json['uid'],
        issuer: IssuerInfo.fromJson(json['issuer']));
  }
}
