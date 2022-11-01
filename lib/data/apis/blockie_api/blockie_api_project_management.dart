part of 'blockie_api.dart';

extension BlockieApiProjectManagement on BlockieApi {
  Future<PaginatedProjects?> getManagedProjects() async {
    final url = _urlBuilder.buildGetManagedProjectsUrl();
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final paginatedProjects = PaginatedProjects.fromJson(object);
      return paginatedProjects;
    } catch (error) {
      return null;
    }
  }

  Future<TicketCheckingDetails?> getManagedProjectNfts({
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
}
