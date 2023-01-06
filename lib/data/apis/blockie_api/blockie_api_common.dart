part of 'blockie_api.dart';

extension BlockieApiCommon on BlockieApi {
  Future<WechatConfig?> getWechatConfig(
    String supportedUrl,
    List<String> apis,
    List<String> openTags,
  ) async {
    try {
      final url = _urlBuilder.buildGetWechatConfigUrl();
      final requestData = {
        'url': supportedUrl,
        'api_list': apis,
        'open_tag_list': openTags,
      };
      final response = await _dio.post(url, data: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final config = WechatConfig.fromJson(object);
      return config;
    } catch (error) {
      return null;
    }
  }

  Future<ReverseAddress?> reverseAddressLookup(
      String latitude, String longitude) async {
    try {
      final url = _urlBuilder.buildReverseAddressLookupUrl();
      final requestData = {'location': '$latitude,$longitude'};
      final response = await _dio.get(url, queryParameters: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final reverseAddress = ReverseAddress.fromJson(object);
      return reverseAddress;
    } catch (error) {
      return null;
    }
  }

  Future<WechatMiniProgramCode?> getWechatMiniProgramCode(String id) async {
    try {
      final url = _urlBuilder.buildGetWechatMiniProgramCodeUrl();
      final requestData = {'page': 'pages/dld/dld', 'scene': 'u=$id'};
      final response = await _dio.get(url, queryParameters: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final code = WechatMiniProgramCode.fromJson(object);
      return code;
    } catch (error) {
      return null;
    }
  }
}
