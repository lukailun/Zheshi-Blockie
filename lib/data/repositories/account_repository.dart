// Project imports:
import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';
import 'package:blockie_app/data/models/token_info.dart';
import 'package:blockie_app/data/models/user_info.dart';
import 'package:blockie_app/data/models/wechat_config.dart';

class AccountRepository {
  final BlockieApi remoteApi;

  AccountRepository({required this.remoteApi});

  Future<TokenInfo?> login(String code) => remoteApi.login(code);

  Future<bool> logout() => remoteApi.logout();

  Future<UserInfo?> getUserInfo() => remoteApi.getUserInfo();

  Future<FaceInfo?> uploadFacePhoto(List<int> bytes, String filename) =>
      remoteApi.uploadFacePhoto(bytes, filename);

  Future<bool> deleteFacePhoto(String faceId) =>
      remoteApi.deleteFacePhoto(faceId);

  Future<WechatConfig?> getWechatConfig(
          String supportedUrl, List<String> apis) =>
      remoteApi.getWechatConfig(supportedUrl, apis);

  Future<String?> getQrCode() => remoteApi.getQrCode();
}
