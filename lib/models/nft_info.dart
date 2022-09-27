import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/models/issuer_info.dart';

class NftInfo {
  final String projectContract;
  final String tokenId;
  final String mintedAt;
  final String cover;
  final String? image;
  final Map<String, String> textures;
  final String model;
  final String video;
  final int type;
  final String uid;
  final String projectName;
  final String projectSummary;
  final int projectAmount;
  final IssuerInfo issuer;
  final UserInfo user;

  NftInfo({
    required this.projectContract,
    required this.tokenId,
    required this.mintedAt,
    required this.cover,
    required this.image,
    required this.textures,
    required this.model,
    required this.video,
    required this.type,
    required this.uid,
    required this.projectName,
    required this.projectSummary,
    required this.projectAmount,
    required this.issuer,
    required this.user
  });

  factory NftInfo.fromJson(Map<String, dynamic> json) {
    final imageData = json['image'];
    // List<String> textures = [imageData['part1']??'', imageData['part2']??'', imageData['part3']??'', imageData['part4']??''];
    return NftInfo(
      tokenId: json['token_id'],
      mintedAt: json['minted_at'],
      cover: Global.assetHost + json['cover'],
      image: Global.assetHost + (json['image']['normal']??''),
      textures: Map.from(json['image']),
      model: json['model']??'',
      video: json['video'] == null ? '' : json['video']['key'],
      type: json['type'],
      uid: json['uid'],
      projectName: json['activity']['name'],
      projectSummary: json['activity']['summary'],
      projectContract: json['activity']['contract'],
      projectAmount: json['activity']['total_amount'],
      issuer: IssuerInfo.fromJson(json['issuer']),
      user: UserInfo.fromJson(json['user'])
    );
  }
}