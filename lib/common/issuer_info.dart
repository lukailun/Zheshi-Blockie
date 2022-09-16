import 'package:blockie_app/common/global.dart';

class IssuerInfo{
  final String title;
  final String summary;
  final String logo;
  final String uid;
  Map<String, dynamic>? json;

  IssuerInfo({
    required this.title,
    required this.summary,
    required this.logo,
    required this.uid,
    this.json
  });

  factory IssuerInfo.fromJson(Map<String, dynamic> json) {
    return IssuerInfo(
      title: json['title'],
      summary: json['summary'] ?? '',
      logo: Global.assetHost + json['logo'],
      uid: json['uid'],
      json: json
    );
  }
}