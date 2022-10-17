// Project imports:
import 'package:blockie_app/models/issuer_info.dart';
import 'global.dart';

class ProjectInfo {
  final String cover;
  final String name;
  final String summary;
  final int totalAmount;
  final String uid;
  final IssuerInfo issuer;

  const ProjectInfo(
      {required this.cover,
      required this.name,
      required this.summary,
      required this.totalAmount,
      required this.uid,
      required this.issuer});

  factory ProjectInfo.fromJson(Map<String, dynamic> json) {
    return ProjectInfo(
        cover: Global.assetHost + json['cover'],
        name: json['name'],
        summary: json['summary'],
        totalAmount: json['total_amount'],
        uid: json['uid'],
        issuer: IssuerInfo.fromJson(json['issuer']));
  }
}
