part of 'blockie_api.dart';

extension BlockieApiAccount on BlockieApi {
  Future<UserInfo?> login(String code) async {
    final url = _urlBuilder.buildLoginUrl();
    final requestData = {
      "code": code,
    };
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      AuthService.to.login();
      Global.userInfo = userInfo;
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<bool> logout() async {
    final url = _urlBuilder.buildLogoutUrl();
    final response = await _dio.delete(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      AuthService.to.logout();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<FaceInfo?> uploadFacePhoto(List<int> bytes, String filename) async {
    final url = _urlBuilder.buildUploadFacePhotoUrl();
    final requestData = FormData.fromMap(
      {
        'face': MultipartFile.fromBytes(
          bytes,
          filename: 'face.jpg',
          contentType: MediaType('image', 'jpeg'),
        )
      },
    );
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      FaceInfo faceInfo = FaceInfo.fromJson(object);
      return faceInfo;
    } catch (error) {
      return null;
    }
  }

  Future<bool> deleteFacePhoto(String faceID) async {
    final url = _urlBuilder.buildDeleteFacePhotoUrl(faceID);
    final response = await _dio.delete(url);
    final Map<String, dynamic> object = response.data;
    final String status = object['status'];
    if (status == 'error') {
      return false;
    }
    return true;
  }

  Future<Profile?> getProfile() async {
    final url = _urlBuilder.buildGetProfileUrl();
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final profile = Profile.fromJson(object);
      return profile;
    } catch (error) {
      return null;
    }
  }
}
