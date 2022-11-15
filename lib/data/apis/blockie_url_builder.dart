// Project imports:
import 'package:blockie_app/models/environment.dart';
import 'package:blockie_app/models/global.dart';

class BlockieUrlBuilder {
  BlockieUrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? Environment.blockieUrl;

  final String _baseUrl;

  static String buildTermsOfServiceUrl() =>
      'https://blockie.fun/public/blockie_privacy.html';

  static String buildPrivacyPolicyUrl() =>
      'https://blockie.fun/public/blockie_privacy.html';

  static String buildAppIconUrl() =>
      '${Global.assetHost}assets/flt/share_icon.png';

  String buildLoginUrl() => '$_baseUrl/login';

  String buildGetUserUrl() => '$_baseUrl/user';

  String buildGetOtherUserInfoUrl() => '$_baseUrl/users';

  String buildGetActivitiesUrl() => '$_baseUrl/groups';

  String buildGetBrandActivitiesUrl(String id) => '$_baseUrl/groups';

  String buildGetProjectDetailsUrl(String id) => '$_baseUrl/rights/$id';

  String buildMintUrl(String id) => '$_baseUrl/rights/$id/mint';

  String buildGetIssuerInfoUrl(String id) => '$_baseUrl/issuers/$id';

  String buildGetQrCodeUrl() => '$_baseUrl/qrcode';

  String buildGetNftsUrl() => '$_baseUrl/NFTs';

  String buildLogoutUrl() => '$_baseUrl/logout';

  String buildUploadFacePhotoUrl() => '$_baseUrl/face';

  String buildDeleteFacePhotoUrl(String faceID) => '$_baseUrl/faces/$faceID';

  String buildGetActivityUrl(String id) => '$_baseUrl/groups/$id/activities';

  String buildGetSubactivityUrl(String id) =>
      '$_baseUrl/activities/$id/tutorial';

  String buildGetRegistrationInfoUrl(String id) =>
      '$_baseUrl/activity/$id/workout';

  String buildUpdateRegistrationInfoUrl(String id) =>
      '$_baseUrl/activity/$id/workout';

  String buildGetProjectDetailsShareInfoUrl(String id) =>
      '$_baseUrl/rights/$id/poster';

  String buildGetNftDetailsShareInfoUrl(String id) =>
      '$_baseUrl/NFTs/$id/poster';

  String buildGetWechatConfigUrl() => '$_baseUrl/wechat';

  // ProjectsManagement
  String buildGetManagedActivitiesUrl() => '$_baseUrl/staff/activities';

  String buildGetManagedProjectNftsUrl(String id) =>
      '$_baseUrl/staff/activities/$id/NFTs';

  String buildGetAirdropNftsUrl(String id) =>
      '$_baseUrl/staff/activities/$id/mint-status';

  String buildAirdropNftsUrl(String id) =>
      '$_baseUrl/staff/activities/$id/mint';

  String buildCheckTicketUrl() => '$_baseUrl/staff/punch-tickets/souvenirs';

  String buildGetWhitelistStatusUrl(String id) =>
      '$_baseUrl/staff/activities/$id';

  String buildAddWhitelistUrl(String id) => '$_baseUrl/staff/activities/$id';

  // Profile
  String buildGetProfileUrl() => '$_baseUrl/my/profile';

  String buildUpdateUserInfoUrl() => '$_baseUrl/user';

  String buildGetAllLabelsUrl() => '$_baseUrl/labels';

  String buildUpdateLabelsUrl() => '$_baseUrl/labels';
}
