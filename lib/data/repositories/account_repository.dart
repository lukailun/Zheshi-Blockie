// Project imports:
import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/data/apis/blockie_api.dart';
import 'package:blockie_app/data/apis/models/wechat_config.dart';
import 'package:blockie_app/models/user_info.dart';
import '../../utils/http_request.dart';

class AccountRepository {
  final BlockieAPI remoteAPI;

  AccountRepository({required this.remoteAPI});

  Future<bool> logout() => remoteAPI.logout();

  Future<UserInfo?> updateUsername(String username) =>
      remoteAPI.updateUsername(username);

  Future<FaceInfo?> uploadFacePhoto(List<int> bytes, String filename) =>
      remoteAPI.uploadFacePhoto(bytes, filename);

  Future<bool> deleteFacePhoto(String faceID) =>
      remoteAPI.deleteFacePhoto(faceID);

  Future<WechatConfig?> getWechatConfig(
          String supportedUrl, List<String> APIs) =>
      remoteAPI.getWechatConfig(supportedUrl, APIs);
}
