part of 'blockie_api.dart';

extension BlockieApiProfile on BlockieApi {
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

  Future<UserInfo?> updateUsername(String username) async {
    final url = _urlBuilder.buildUpdateUserInfoUrl();
    final requestData = {"nickname": username};
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      Global.userInfo = userInfo;
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<UserInfo?> updateBio(String bio) async {
    final url = _urlBuilder.buildUpdateUserInfoUrl();
    final requestData = {"biography": bio};
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      Global.userInfo = userInfo;
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<List<ProfileLabel>?> getAllLabels() async {
    final url = _urlBuilder.buildGetAllLabelsUrl();
    final response = await _dio.get(url);
    try {
      final List list = BlockieApi._getResponseData(response);
      final labels = list.map((it) => ProfileLabel.fromJson(it)).toList();
      return labels;
    } catch (error) {
      return null;
    }
  }

  Future<List<ProfileLabel>?> updateLabels(List<String> ids) async {
    final url = _urlBuilder.buildUpdateLabelsUrl();
    final requestData = {"label_uids": ids};
    final response = await _dio.post(url, data: requestData);
    try {
      final List list = BlockieApi._getResponseData(response);
      final labels = list.map((it) => ProfileLabel.fromJson(it)).toList();
      return labels;
    } catch (error) {
      return null;
    }
  }
}
