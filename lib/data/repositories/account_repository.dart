import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/models/user_info.dart';

import '../../utils/http_request.dart';

class AccountRepository {
  final HttpRequest client;

  AccountRepository({required this.client});

  Future<bool> logout() => client.logout();

  Future<UserInfo> updateUsername(String username) =>
      client.updateUsername(username);

  Future<FaceInfo?> uploadFacePhoto(List<int> bytes, String filename) =>
      client.uploadFacePhoto(bytes, filename);
}
