part of 'blockie_api.dart';

extension BlockieApiAccount on BlockieApi {
  Future<TokenInfo?> login(String code) async {
    try {
      final url = _urlBuilder.buildLoginUrl();
      final requestData = {"code": code};
      final response = await _dio.post(url, data: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final tokenInfo = TokenInfo.fromJson(object);
      AuthService.to.login();
      return tokenInfo;
    } catch (error) {
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      final url = _urlBuilder.buildLogoutUrl();
      final response = await _dio.post(url);
      BlockieApi._getResponseData(response);
      AuthService.to.logout();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<FaceInfo?> uploadFacePhoto(List<int> bytes, String filename) async {
    try {
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
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      FaceInfo faceInfo = FaceInfo.fromJson(object);
      return faceInfo;
    } catch (error) {
      return null;
    }
  }

  Future<bool> deleteFacePhoto(String faceID) async {
    try {
      final url = _urlBuilder.buildDeleteFacePhotoUrl(faceID);
      final response = await _dio.post(url);
      final Map<String, dynamic> object = response.data;
      final String status = object['status'];
      if (status == 'error') {
        return false;
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<String?> getQrCode() async {
    try {
      final url = _urlBuilder.buildGetQrCodeUrl();
      final response = await _dio.get(url);
      final String qrCode = BlockieApi._getResponseData(response);
      return qrCode;
    } catch (error) {
      return null;
    }
  }

  Future<UserInfo?> getUserInfo() async {
    try {
      final url = _urlBuilder.buildGetUserInfoUrl();
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<UserInfo?> updateUsername(String username) async {
    try {
      final url = _urlBuilder.buildUpdateUserInfoUrl();
      final requestData = {"nickname": username};
      final response = await _dio.post(url, data: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<UserInfo?> updateBio(String bio) async {
    try {
      final url = _urlBuilder.buildUpdateUserInfoUrl();
      final requestData = {"biography": bio};
      final response = await _dio.post(url, data: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<UserInfo?> updateGender(int gender) async {
    try {
      final url = _urlBuilder.buildUpdateUserInfoUrl();
      final requestData = {"gender": gender};
      final response = await _dio.post(url, data: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<UserInfo?> updateBirthday(String birthday) async {
    try {
      final url = _urlBuilder.buildUpdateUserInfoUrl();
      final requestData = {"birth_date": birthday};
      final response = await _dio.post(url, data: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<UserInfo?> updateRegion(String region) async {
    try {
      final url = _urlBuilder.buildUpdateUserInfoUrl();
      final requestData = {"locale": region};
      final response = await _dio.post(url, data: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      return userInfo;
    } catch (error) {
      return null;
    }
  }
}
