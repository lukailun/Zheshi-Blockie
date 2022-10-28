// Project imports:
import 'global.dart';

class UserInfo {
  final String nickname;
  final String avatar;
  final String? phone;
  final int? level;
  final String uid;
  final String? walletAddress;
  final List<String>? roles;

  UserInfo({
    required this.nickname,
    required this.avatar,
    required this.phone,
    required this.level,
    required this.uid,
    required this.walletAddress,
    required this.roles,
  });

  bool get isStaff => roles?.contains('staff') ?? false;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      nickname: json['nickname'],
      avatar: Global.assetHost + json['avatar'],
      phone: json['phone'],
      level: json['level'],
      uid: json['uid'],
      walletAddress:
          json['wallets'] == null ? null : json['wallets'][0]['address'],
      roles: json['wallets'] == null
          ? null
          : (json['roles'] as List).map((it) => it as String).toList(),
    );
  }
}
