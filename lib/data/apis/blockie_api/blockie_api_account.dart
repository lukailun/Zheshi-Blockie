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
    final response = await _dio.post(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      AuthService.to.logout();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<UserInfo?> getUser() async {
    final url = _urlBuilder.buildGetUserUrl();
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final user = UserInfo.fromJson(object);
      Global.userInfo = user;
      return user;
    } catch (error) {
      return null;
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
    final response = await _dio.post(url);
    final Map<String, dynamic> object = response.data;
    final String status = object['status'];
    if (status == 'error') {
      return false;
    }
    return true;
  }

  Future<WechatConfig?> getWechatConfig(
      String supportedUrl, List<String> apis) async {
    final url = _urlBuilder.buildGetWechatConfigUrl();
    final requestData = {
      'url': supportedUrl,
      'api_list': apis,
    };
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final config = WechatConfig.fromJson(object);
      return config;
    } catch (error) {
      return null;
    }
  }

  Future<String?> getQrCode() async {
    final url = _urlBuilder.buildGetQrCodeUrl();
    final response = await _dio.get(url);
    try {
      final String qrCode = BlockieApi._getResponseData(response);
      return qrCode;
    } catch (error) {
      return null;
    }
  }
}
