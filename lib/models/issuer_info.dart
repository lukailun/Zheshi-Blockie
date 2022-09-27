import 'package:blockie_app/models/global.dart';

class IssuerInfo{
  final String title;
  final String summary;
  final String logo;
  final String uid;

  IssuerInfo({
    required this.title,
    required this.summary,
    required this.logo,
    required this.uid
  });

  factory IssuerInfo.fromJson(Map<String, dynamic> json) {
    return IssuerInfo(
      title: json['title'],
      summary: json['summary'] ?? '',
      logo: Global.assetHost + json['logo'],
      uid: json['uid']
    );
  }
}