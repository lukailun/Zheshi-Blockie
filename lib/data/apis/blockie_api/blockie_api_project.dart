part of 'blockie_api.dart';

extension BlockieApiProject on BlockieApi {
  Future<NftDetails?> getNftDetails(String id) async {
    try {
      final url = _urlBuilder.buildGetNftDetailsUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final nftDetails = NftDetails.fromJson(object);
      return nftDetails;
    } catch (error) {
      return null;
    }
  }

  Future<PaginatedActivities?> getActivities() async {
    try {
      final url = _urlBuilder.buildGetActivitiesUrl();
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final paginatedActivities = PaginatedActivities.fromJson(object);
      return paginatedActivities;
    } catch (error) {
      return null;
    }
  }

  Future<Issuer?> getIssuerInfo(String id) async {
    try {
      final url = _urlBuilder.buildGetIssuerInfoUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final issuer = Issuer.fromJson(object);
      return issuer;
    } catch (error) {
      return null;
    }
  }

  Future<PaginatedActivities?> getBrandActivities(String id) async {
    try {
      final url = _urlBuilder.buildGetBrandActivitiesUrl(id);
      final requestData = {'issuer_uid': id};
      final response = await _dio.get(url, queryParameters: requestData);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final paginatedActivities = PaginatedActivities.fromJson(object);
      return paginatedActivities;
    } catch (error) {
      return null;
    }
  }

  Future<Activity?> getActivity(String id) async {
    try {
      final url = _urlBuilder.buildGetActivityUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final activity = Activity.fromJson(object);
      return activity;
    } catch (error) {
      return null;
    }
  }

  Future<Subactivity?> getSubactivity(String id) async {
    try {
      final url = _urlBuilder.buildGetSubactivityUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final subactivity = Subactivity.fromJson(object);
      return subactivity;
    } catch (error) {
      return null;
    }
  }

  Future<bool> submitToFinish(String id) async {
    try {
      final url = _urlBuilder.buildSubmitToFinishUrl(id);
      final response = await _dio.post(url);
      BlockieApi._getResponseData(response);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<ProjectDetails?> getProjectDetails(String id) async {
    try {
      final url = _urlBuilder.buildGetProjectDetailsUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final projectDetails = ProjectDetails.fromJson(object);
      return projectDetails;
    } catch (error) {
      return null;
    }
  }

  Future<RegistrationInfo?> getRegistrationInfo(String id) async {
    try {
      final url = _urlBuilder.buildGetRegistrationInfoUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final registrationInfo = RegistrationInfo.fromJson(object);
      return registrationInfo;
    } catch (error) {
      return null;
    }
  }

  Future<bool> updateRegistrationInfo(
      String id, String number, bool isUpdate) async {
    try {
      final url = _urlBuilder.buildUpdateRegistrationInfoUrl(id);
      final requestData = {
        'number': number,
        'action': isUpdate ? 'update' : 'create',
      };
      final response = await _dio.post(url, data: requestData);
      BlockieApi._getResponseData(response);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<NftDetails?> mint(String id) async {
    try {
      final url = _urlBuilder.buildMintUrl(id);
      final response = await _dio.post(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final nft = NftDetails.fromJson(object);
      return nft;
    } catch (error) {
      return null;
    }
  }

  Future<ShareInfo?> getNftDetailsShareInfo(String id) async {
    try {
      final url = _urlBuilder.buildGetNftDetailsShareInfoUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final shareInfo = ShareInfo.fromJson(object);
      return shareInfo;
    } catch (error) {
      return null;
    }
  }

  Future<ShareInfo?> getProjectDetailsShareInfo(String id) async {
    try {
      final url = _urlBuilder.buildGetProjectDetailsShareInfoUrl(id);
      final response = await _dio.get(url);
      final Map<String, dynamic> object = BlockieApi._getResponseData(response);
      final shareInfo = ShareInfo.fromJson(object);
      return shareInfo;
    } catch (error) {
      return null;
    }
  }
}
