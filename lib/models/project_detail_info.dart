// Project imports:
import 'package:blockie_app/models/issuer_info.dart';
import 'global.dart';

class ProjectDetailInfo {
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
  final int startedTime;
  final int endedTime;
  final String uid;
  final IssuerInfo issuer;

  const ProjectDetailInfo(
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

  factory ProjectDetailInfo.fromJson(Map<String, dynamic> json) {
    List<String> images = json['images']
        .map<String>((e) => Global.assetHost + e.toString())
        .toList();
    return ProjectDetailInfo(
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
