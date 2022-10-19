// Project imports:
import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/data/apis/blockie_api.dart';
import 'package:blockie_app/data/apis/models/wechat_config.dart';
import 'package:blockie_app/models/user_info.dart';

class AccountRepository {
  final BlockieApi remoteApi;

  AccountRepository({required this.remoteApi});

  Future<bool> logout() => remoteApi.logout();

  Future<UserInfo?> updateUsername(String username) =>
      remoteApi.updateUsername(username);

  Future<FaceInfo?> uploadFacePhoto(List<int> bytes, String filename) =>
      remoteApi.uploadFacePhoto(bytes, filename);

  Future<bool> deleteFacePhoto(String faceId) =>
      remoteApi.deleteFacePhoto(faceId);

  Future<WechatConfig?> getWechatConfig(
          String supportedUrl, List<String> Apis) =>
      remoteApi.getWechatConfig(supportedUrl, Apis);
}
