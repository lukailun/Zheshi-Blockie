import 'global.dart';

class UserInfo{
  final String nickname;
  final String avatar;
  final String? phone;
  final int? level;
  final String uid;
  final String? walletAddress;

  UserInfo({
    required this.nickname,
    required this.avatar,
    required this.phone,
    required this.level,
    required this.uid,
    required this.walletAddress
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      nickname: json['nickname'],
      avatar: Global.assetHost + json['avatar'],
      phone: json['phone'],
      level: json['level'],
      uid: json['uid'],
      walletAddress: json['wallets'] == null ? null : json['wallets'][0]['address']
    );
  }
}