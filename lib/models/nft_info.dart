// Project imports:
import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/issuer.dart';
import 'package:blockie_app/models/user_info.dart';

class NftInfo {
  final String projectContract;
  final String tokenId;
  final String mintedAt;
  final String cover;
  final String? image;
  final Map<String, String> textures;
  final List<Map<String, String>> modelImage;
  final String model;
  final String video;
  final int type;
  final String uid;
  final String projectName;
  final String projectSummary;
  final int projectAmount;
  final Issuer issuer;
  final UserInfo user;

  NftInfo(
      {required this.projectContract,
      required this.tokenId,
      required this.mintedAt,
      required this.cover,
      required this.image,
      required this.textures,
      required this.modelImage,
      required this.model,
      required this.video,
      required this.type,
      required this.uid,
      required this.projectName,
      required this.projectSummary,
      required this.projectAmount,
      required this.issuer,
      required this.user});

  factory NftInfo.fromJson(Map<String, dynamic> json) {
    return NftInfo(
        tokenId: json['token_id'],
        mintedAt: json['minted_at'],
        cover: Global.assetHost + json['cover'],
        image: Global.assetHost + (json['image']['normal'] ?? ''),
        textures: Map.from(json['image']),
        modelImage: json['model_image'] == null ? [] : (json['model_image'] as List).map((e) => Map<String, String>.from(e)).toList(),
        model: json['model'] ?? '',
        video: json['video'] ?? '',
        type: json['type'],
        uid: json['uid'],
        projectName: json['activity']['name'],
        projectSummary: json['activity']['summary'],
        projectContract: json['activity']['contract'],
        projectAmount: json['activity']['total_amount'],
        issuer: Issuer.fromJson(json['issuer']),
        user: UserInfo.fromJson(json['user']));
  }
}
