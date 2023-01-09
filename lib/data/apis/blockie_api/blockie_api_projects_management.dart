part of 'blockie_api.dart';

extension BlockieApiProjectsManagement on BlockieApi {
  Future<PaginatedManagedActivities?> getManagedActivities() async {
    try {
      final url = _urlBuilder.buildGetManagedActivitiesUrl();
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final paginatedManagedActivities =
          PaginatedManagedActivities.fromJson(object);
      return paginatedManagedActivities;
    } catch (error) {
      return null;
    }
  }

  Future<List<Project>?> getManagedProjects({
    required String id,
  }) async {
    try {
      final url = _urlBuilder.buildGetManagedProjectsUrl(id);
      final response = await _dio.get(url);
      final List list = BlockieApi._getResponseData(response);
      final projects = list.map((it) => Project.fromJson(it)).toList();
      return projects;
    } catch (error) {
      return null;
    }
  }

  Future<TicketCheckingDetails?> getTicketCheckingDetails({
    required String id,
    required String qrCode,
  }) async {
    try {
      final url = _urlBuilder.buildGetManagedProjectNftsUrl(id);
      final parameters = {'qrcode_text': qrCode};
      final response = await _dio.get(url, queryParameters: parameters);
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
    try {
      final url = _urlBuilder.buildGetManagedProjectNftsUrl(id);
      final parameters = {'qrcode_text': qrCode};
      final response = await _dio.get(url, queryParameters: parameters);
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
    try {
      final url = _urlBuilder.buildGetAirdropNftsUrl(id);
      final parameters = {'qrcode_text': qrCode};
      final response = await _dio.get(url, queryParameters: parameters);
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
    try {
      final url = _urlBuilder.buildAirdropNftsUrl(id);
      final parameters = {'qrcode_text': qrCode};
      final response = await _dio.post(url, queryParameters: parameters);
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
    try {
      final url = _urlBuilder.buildCheckTicketUrl();
      final parameters = {
        'qrcode_text': qrCode,
        'souvenirs': souvenirsMapList,
      };
      final response = await _dio.post(url, queryParameters: parameters);
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
    try {
      final url = _urlBuilder.buildGetWhitelistStatusUrl(id);
      final parameters = {'qrcode_text': qrCode};
      final response = await _dio.get(url, queryParameters: parameters);
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
    try {
      final url = _urlBuilder.buildAddWhitelistUrl(id);
      final parameters = {'qrcode_text': qrCode};
      final response = await _dio.post(url, queryParameters: parameters);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final details = AddWhitelistDetails.fromJson(object);
      return details;
    } catch (error) {
      return null;
    }
  }
}
