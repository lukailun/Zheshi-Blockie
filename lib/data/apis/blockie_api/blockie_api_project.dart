part of 'blockie_api.dart';

extension BlockieApiProject on BlockieApi {
  Future<PaginatedActivities?> getActivities() async {
    final url = _urlBuilder.buildGetActivitiesUrl();
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final paginatedActivities = PaginatedActivities.fromJson(object);
      return paginatedActivities;
    } catch (error) {
      return null;
    }
  }
}
