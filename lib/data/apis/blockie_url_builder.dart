import 'package:blockie_app/models/global.dart';

class BlockieUrlBuilder {
  const BlockieUrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://s.blockie.zheshi.tech/api/v1';

  final String _baseUrl;

  static String buildTermsOfServiceUrl() =>
      'https://blockie.fun/public/blockie_privacy.html';

  static String buildPrivacyPolicyUrl() =>
      'https://blockie.fun/public/blockie_privacy.html';

  static String buildAppIconUrl() => '${Global.assetHost}/app_icon.png';

  String buildLoginUrl() => '$_baseUrl/login';

  String buildGetUserInfoUrl() => '$_baseUrl/user';

  String buildGetOtherUserInfoUrl() => '$_baseUrl/users';

  String buildGetProjectsUrl() => '$_baseUrl/activities';

  String buildGetIssuerInfoUrl() => '$_baseUrl/issuers';

  String buildGetQRCodeUrl() => '$_baseUrl/qrcode';

  String buildGetNFTsUrl() => '$_baseUrl/NFTs';

  String buildLogoutUrl() => '$_baseUrl/logout';

  String buildUpdateUserInfoUrl() => '$_baseUrl/user';

  String buildUploadFacePhotoUrl() => '$_baseUrl/face';

  String buildDeleteFacePhotoUrl(String faceID) => '$_baseUrl/faces/$faceID';

  String buildGetEventUrl(String ID) => '$_baseUrl/groups/$ID/poster';

  String buildGetRegistrationInfoUrl(String ID) =>
      '$_baseUrl/groups/$ID/workout';

  String buildUpdateRegistrationInfoUrl(String ID) =>
      '$_baseUrl/groups/$ID/workout';

  String buildGetShareInfoUrl(String ID) => '$_baseUrl/activities/$ID/poster';

  String buildGetNFTShareInfoUrl(String ID) => '$_baseUrl/NFTs/$ID/poster';

  String buildGetWechatConfigUrl() => '$_baseUrl/wechat';
}
