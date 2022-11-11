part of 'blockie_api.dart';

extension BlockieApiProjectsManagement on BlockieApi {
  Future<PaginatedManagedActivities?> getManagedActivities() async {
    final url = _urlBuilder.buildGetManagedActivitiesUrl();
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final paginatedManagedActivities = PaginatedManagedActivities.fromJson(object);
      return paginatedManagedActivities;
    } catch (error) {
      return null;
    }
  }

  Future<TicketCheckingDetails?> getTicketCheckingDetails({
    required String id,
    required String qrCode,
  }) async {
    final url = _urlBuilder.buildGetManagedProjectNftsUrl(id);
    final requestData = {
      'qrcode_text': qrCode,
    };
    final response = await _dio.get(url, queryParameters: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final details = TicketCheckingDetails.fromJson(object);
      return details;
    } catch (error) {
      return null;
    }
  }

  Future<HoldVerificationDetails?> getHoldVerificationDetails({
    required String id,
    required String qrCode,
  }) async {
    final url = _urlBuilder.buildGetManagedProjectNftsUrl(id);
    final requestData = {
      'qrcode_text': qrCode,
    };
    final response = await _dio.get(url, queryParameters: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final details = HoldVerificationDetails.fromJson(object);
      return details;
    } catch (error) {
      return null;
    }
  }

  Future<AirdropNftDetails?> getAirdropNfts({
    required String id,
    required String qrCode,
  }) async {
    final url = _urlBuilder.buildGetAirdropNftsUrl(id);
    final requestData = {
      'qrcode_text': qrCode,
    };
    final response = await _dio.get(url, queryParameters: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final details = AirdropNftDetails.fromJson(object);
      return details;
    } catch (error) {
      return null;
    }
  }

  Future<AirdropNftDetails?> airdropNfts({
    required String id,
    required String qrCode,
  }) async {
    final url = _urlBuilder.buildAirdropNftsUrl(id);
    final requestData = {
      'qrcode_text': qrCode,
    };
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final details = AirdropNftDetails.fromJson(object);
      return details;
    } catch (error) {
      return null;
    }
  }

  Future<TicketCheckingDetails?> checkTickets({
    required List<Map<String, String>> souvenirsMapList,
    required String qrCode,
  }) async {
    final url = _urlBuilder.buildCheckTicketUrl();
    final requestData = {
      'qrcode_text': qrCode,
      'souvenirs': souvenirsMapList,
    };
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final details = TicketCheckingDetails.fromJson(object);
      return details;
    } catch (error) {
      return null;
    }
  }

  Future<AddWhitelistDetails?> getWhitelistStatus({
    required String id,
    required String qrCode,
  }) async {
    final url = _urlBuilder.buildGetWhitelistStatusUrl(id);
    final requestData = {
      'qrcode_text': qrCode,
    };
    final response = await _dio.get(url, queryParameters: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final details = AddWhitelistDetails.fromJson(object);
      return details;
    } catch (error) {
      return null;
    }
  }

  Future<AddWhitelistDetails?> addWhitelist({
    required String id,
    required String qrCode,
  }) async {
    final url = _urlBuilder.buildAddWhitelistUrl(id);
    final requestData = {
      'qrcode_text': qrCode,
    };
    final response = await _dio.post(url, queryParameters: requestData);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final details = AddWhitelistDetails.fromJson(object);
      return details;
    } catch (error) {
      return null;
    }
  }
}
