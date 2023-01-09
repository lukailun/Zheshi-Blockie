// Project imports:
import 'package:blockie_app/data/models/environment.dart';

class BlockieUrlBuilder {
  BlockieUrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? Environment.blockieUrl;

  final String _baseUrl;

  static String resourceHost = "https://cdn.blockie.fun";

  static String buildTermsOfServiceUrl() =>
      'https://blockie.fun/public/blockie_privacy.html';

  static String buildPrivacyPolicyUrl() =>
      'https://blockie.fun/public/blockie_privacy.html';

  static String buildAppIconUrl() => '$resourceHost/assets/flt/share_icon.png';

  static String buildWechatAuthorizationUrl(String redirectUrl) =>
      'https://open.weixin.qq.com/connect/oauth2/authorize?appid=${Environment.wechatOfficialAccountId}&redirect_uri=${Uri.encodeComponent(redirectUrl)}&response_type=code&scope=snsapi_base#wechat_redirect';

  String buildLoginUrl() => '$_baseUrl/login';

  String buildGetUserInfoUrl() => '$_baseUrl/user';

  String buildGetActivitiesUrl() => '$_baseUrl/groups';

  String buildGetBrandActivitiesUrl(String id) => '$_baseUrl/groups';

  String buildGetProjectDetailsUrl(String id) => '$_baseUrl/rights/$id';

  String buildMintUrl(String id) => '$_baseUrl/rights/$id/mint';

  String buildGetIssuerInfoUrl(String id) => '$_baseUrl/issuers/$id';

  String buildGetQrCodeUrl() => '$_baseUrl/qrcode';

  String buildGetNftDetailsUrl(String id) => '$_baseUrl/NFTs/$id';

  String buildLogoutUrl() => '$_baseUrl/logout';

  String buildUploadFacePhotoUrl() => '$_baseUrl/face';

  String buildDeleteFacePhotoUrl(String faceID) => '$_baseUrl/faces/$faceID';

  String buildGetActivityUrl(String id) => '$_baseUrl/groups/$id/activities';

  String buildGetSubactivityUrl(String id) =>
      '$_baseUrl/activities/$id/tutorial';

  String buildSubmitToFinishUrl(String id) =>
      '$_baseUrl/activity/$id/workout-finish';

  String buildGetRegistrationInfoUrl(String id) =>
      '$_baseUrl/activity/$id/workout';

  String buildUpdateRegistrationInfoUrl(String id) =>
      '$_baseUrl/activity/$id/workout';

  String buildGetProjectDetailsShareInfoUrl(String id) =>
      '$_baseUrl/rights/$id/poster';

  String buildGetNftDetailsShareInfoUrl(String id) =>
      '$_baseUrl/NFTs/$id/poster';

  String buildGetWechatConfigUrl() => '$_baseUrl/wechat';

  /// 逆地址解析（坐标位置描述）: https://lbs.qq.com/service/webService/webServiceGuide/webServiceGcoder
  String buildReverseAddressLookupUrl() => '$_baseUrl/location';

  String buildGetWechatMiniProgramCodeUrl() => '$_baseUrl/wechat-app-code';

  String buildGetWechatSilentAuthRedirectUrl(
          String userId, String redirectUrlPrefix, String? redirectUrlSuffix) =>
      '$_baseUrl/wx-silent-login?user_uid=$userId&redirect_prefix=$redirectUrlPrefix${(redirectUrlSuffix ?? '').isNotEmpty ? '&redirect_suffix=${redirectUrlSuffix ?? ''}' : ''}';

  // ProjectsManagement
  String buildGetManagedActivitiesUrl() => '$_baseUrl/staff/activities';

  String buildGetManagedProjectsUrl(String id) =>
      '$_baseUrl/staff/activities/$id/rights';

  String buildGetManagedProjectNftsUrl(String id) =>
      '$_baseUrl/staff/rights/$id/NFTs';

  String buildGetAirdropNftsUrl(String id) =>
      '$_baseUrl/staff/rights/$id/mint-status';

  String buildAirdropNftsUrl(String id) => '$_baseUrl/staff/rights/$id/mint';

  String buildCheckTicketUrl() => '$_baseUrl/staff/punch-tickets/souvenirs';

  String buildGetWhitelistStatusUrl(String id) => '$_baseUrl/staff/rights/$id';

  String buildAddWhitelistUrl(String id) => '$_baseUrl/staff/rights/$id';

  // Profile
  String buildGetProfileUrl() => '$_baseUrl/my/profile';

  String buildUpdateUserInfoUrl() => '$_baseUrl/user';

  String buildGetAllLabelsUrl() => '$_baseUrl/labels';

  String buildUpdateLabelsUrl() => '$_baseUrl/labels';

  // Finance
  String buildGetCartUrl(String id) => '$_baseUrl/activities/$id/cart';

  String buildUpdateCartUrl(String id) => '$_baseUrl/merches/$id/add-to-cart';

  String buildSubmitOrderUrl(String id) =>
      '$_baseUrl/activities/$id/checkout-cart';

  String buildGetOrdersUrl() => '$_baseUrl/orders';
}
