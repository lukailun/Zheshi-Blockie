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

  Future<PaginatedActivities?> getBrandActivities(String id) async {
    final url = _urlBuilder.buildGetBrandActivitiesUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final paginatedActivities = PaginatedActivities.fromJson(object);
      return paginatedActivities;
    } catch (error) {
      return null;
    }
  }

  Future<Activity?> getActivity(String id) async {
    final url = _urlBuilder.buildGetActivityUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final activity = Activity.fromJson(object);
      return activity;
    } catch (error) {
      return null;
    }
  }

  Future<Subactivity?> getSubactivity(String id) async {
    final url = _urlBuilder.buildGetSubactivityUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final subactivity = Subactivity.fromJson(object);
      return subactivity;
    } catch (error) {
      return null;
    }
  }

  Future<ProjectDetails?> getProjectDetails(String id) async {
    final url = _urlBuilder.buildGetProjectDetailsUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final projectDetails = ProjectDetails.fromJson(object);
      return projectDetails;
    } catch (error) {
      return null;
    }
  }

  Future<RegistrationInfo?> getRegistrationInfo(String id) async {
    final url = _urlBuilder.buildGetRegistrationInfoUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final registrationInfo = RegistrationInfo.fromJson(object);
      return registrationInfo;
    } catch (error) {
      return null;
    }
  }

  Future<bool> updateRegistrationInfo(
      String id, String number, bool isUpdate) async {
    final url = _urlBuilder.buildUpdateRegistrationInfoUrl(id);

    final requestData = {
      'number': number,
      'action': isUpdate ? 'update' : 'create',
    };
    final response = await _dio.post(url, data: requestData);
    try {
      BlockieApi._getResponseData(response);
      return true;
    } catch (error) {
      return false;
    }
  }
}
