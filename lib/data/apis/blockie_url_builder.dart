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

  String buildGetUserInfoUrl() => '$_baseUrl/user';

  String buildGetOtherUserInfoUrl() => '$_baseUrl/users';

  String buildGetProjectsUrl() => '$_baseUrl/activities';

  String buildGetProjectDetailsUrl(String id) => '$_baseUrl/activities/$id';

  String buildMintUrl(String id) => '$_baseUrl/activities/$id/mint';

  String buildGetIssuerInfoUrl() => '$_baseUrl/issuers';

  String buildGetQrCodeUrl() => '$_baseUrl/qrcode';

  String buildGetNftsUrl() => '$_baseUrl/NFTs';

  String buildLogoutUrl() => '$_baseUrl/logout';

  String buildUpdateUserInfoUrl() => '$_baseUrl/user';

  String buildUploadFacePhotoUrl() => '$_baseUrl/face';

  String buildDeleteFacePhotoUrl(String faceID) => '$_baseUrl/faces/$faceID';

  String buildGetActivityUrl(String id) => '$_baseUrl/groups/$id/poster';

  String buildGetRegistrationInfoUrl(String id) =>
      '$_baseUrl/groups/$id/workout';

  String buildUpdateRegistrationInfoUrl(String id) =>
      '$_baseUrl/groups/$id/workout';

  String buildGetProjectDetailsShareInfoUrl(String id) =>
      '$_baseUrl/activities/$id/poster';

  String buildGetNftDetailsShareInfoUrl(String id) =>
      '$_baseUrl/NFTs/$id/poster';

  String buildGetWechatConfigUrl() => '$_baseUrl/wechat';

  String buildGetProfileUrl() => '$_baseUrl/my/profile';

  String buildGetManagedProjectsUrl() => '$_baseUrl/staff/activities';

  String buildGetManagedProjectNftsUrl(String id) =>
      '$_baseUrl/staff/activities/$id/NFTs';

  String buildCheckTicketUrl() => '$_baseUrl/staff/punch-tickets/souvenirs';
}
