part of 'blockie_api.dart';

extension BlockieApiProfile on BlockieApi {
  Future<Profile?> getProfile() async {
    try {
      final url = _urlBuilder.buildGetProfileUrl();
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final profile = Profile.fromJson(object);
      return profile;
    } catch (error) {
      return null;
    }
  }

  Future<List<ProfileLabel>?> getAllLabels() async {
    try {
      final url = _urlBuilder.buildGetAllLabelsUrl();
      final response = await _dio.get(url);
      final List list = BlockieApi._getResponseData(response);
      final labels = list.map((it) => ProfileLabel.fromJson(it)).toList();
      return labels;
    } catch (error) {
      return null;
    }
  }

  Future<List<ProfileLabel>?> updateLabels(List<String> ids) async {
    try {
      final url = _urlBuilder.buildUpdateLabelsUrl();
      final parameters = {"label_uids": ids};
      final response = await _dio.post(url, queryParameters: parameters);
      final List list = BlockieApi._getResponseData(response);
      final labels = list.map((it) => ProfileLabel.fromJson(it)).toList();
      return labels;
    } catch (error) {
      return null;
    }
  }
}
