// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

// Project imports:
import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/app/modules/registration_info/models/registration_info.dart';
import 'package:blockie_app/app/modules/share/models/share_info.dart';
import 'package:blockie_app/data/apis/models/wechat_config.dart';
import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/issuer_info.dart';
import 'package:blockie_app/models/nft_info.dart';
import 'package:blockie_app/models/nft_load_info.dart';
import 'package:blockie_app/models/project_detail_info.dart';
import 'package:blockie_app/models/project_group.dart';
import 'package:blockie_app/models/project_group_load_info.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import '../app/modules/activity/models/activity.dart';
import 'data_storage.dart';

const scheme = "https";
const serverHost = "s.blockie.zheshi.tech";
const commandPath = "/api/v1";
const loginCommand = "/login";
const getUserInfoCommand = "/user";
const getOtherUserInfoCommand = "/users";
const getProjectsCommand = "/activities";
const getIssuerInfoCommand = "/issuers";
const getUserQRCodeCommand = "/qrcode";
const getUserNftListCommand = "/NFTs";
const logoutCommand = "/logout";
const updateUserInfoCommand = "/user";
const uploadFacePhotoCommand = "/face";
const getProjectCommand = "/groups/@/poster";
const getRegistrationInfoCommand = "/groups/@/workout";
const updateRegistrationInfoCommand = "/groups/@/workout";
const getShareInfoCommand = "/activities/@/poster";
const getNFTShareInfoCommand = "/NFTs/@/poster";
const getWechatConfigCommand = "/wechat";

class HttpRequest {
  static final dio = Dio();

  static dynamic _getResponseData(Response response) {
    final res = jsonDecode(response.toString());
    String status = res['status'];
    if (status == 'success') {
      return res['data'];
    } else if (status == 'error') {
      throw Exception(res['err_msg']);
    }
  }

  static Future<Map<String, dynamic>> login(String code) async {
    final url =
        Uri(scheme: scheme, host: serverHost, path: commandPath + loginCommand);
    final data = {'code': code};
    final response = await dio.postUri(url, data: data);
    if (response.statusCode == 200) {
      AuthService.to.login();
      final res = HttpRequest._getResponseData(response);
      String token = res['token'];
      UserInfo userInfo = UserInfo.fromJson(res);
      return {'token': token, 'user': userInfo};
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<UserInfo> getUserInfo(String token) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getUserInfoCommand);
    final response = await dio.getUri(url,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      UserInfo userInfo = UserInfo.fromJson(res);
      Global.userInfo = userInfo;
      return userInfo;
    } else {
      throw Exception('Failed to get user info');
    }
  }

  static Future<UserInfo> getOtherUserInfo(String uid) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: "$commandPath$getOtherUserInfoCommand/$uid");
    final response = await dio.getUri(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      UserInfo userInfo = UserInfo.fromJson(res);
      return userInfo;
    } else {
      throw Exception('Failed to get user info');
    }
  }

  static Future<ProjectGroupLoadInfo> loadBrandGroups(
      {String? pageUrl, String? issuerUid}) async {
    final url = pageUrl == null
        ? Uri(
            scheme: scheme,
            host: serverHost,
            path: commandPath + getProjectsCommand,
            queryParameters: {'issuer_uid': issuerUid})
        : Uri.parse(pageUrl);
    final response = await dio.getUri(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      String? nextPageUrl = res['next_page_url'];
      List<ProjectGroup> projectGroups = [];
      for (final data in res['data']) {
        projectGroups.add(ProjectGroup.fromJson(data));
      }
      return ProjectGroupLoadInfo(
          nextPageUrl: nextPageUrl, projectGroups: projectGroups);
    } else {
      throw Exception('Failed to get projects');
    }
  }

  static Future<ProjectGroupLoadInfo> loadProjectGroups(
      {String? pageUrl}) async {
    final url = pageUrl == null
        ? Uri(
            scheme: scheme,
            host: serverHost,
            path: commandPath + getProjectsCommand)
        : Uri.parse(pageUrl);
    final response = await dio.getUri(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      String? nextPageUrl = res['next_page_url'];
      List<ProjectGroup> projectGroups = [];
      for (final data in res['data']) {
        projectGroups.add(ProjectGroup.fromJson(data));
      }
      return ProjectGroupLoadInfo(
          nextPageUrl: nextPageUrl, projectGroups: projectGroups);
    } else {
      throw Exception('Failed to get project groups');
    }
  }

  static Future<ProjectGroup> loadProjectGroup(
      {required String groupUid}) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getProjectsCommand,
        queryParameters: {'group_uid': groupUid});
    final response = await dio.getUri(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      if (res['data'].length > 0) {
        return ProjectGroup.fromJson(res['data'][0]);
      } else {
        throw Exception('Failed to get project group');
      }
    } else {
      throw Exception('Failed to get project group');
    }
  }

  static Future<ProjectDetailInfo> loadProjectDetail(
      {String? uid, String? issuerUid, String? token}) async {
    String? projectUid;
    if (uid != null) {
      projectUid = uid;
    } else if (issuerUid != null) {
      projectUid = issuerUid;
    } else {
      throw Exception('Project uid is null');
    }

    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: '$commandPath$getProjectsCommand/$projectUid');
    final response = token == null
        ? await dio.getUri(url)
        : await dio.getUri(url,
            options: Options(headers: {'Authorization': 'Bearer $token'}));
    ;
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      return ProjectDetailInfo.fromJson(res);
    } else {
      throw Exception('Failed to get project detail');
    }
  }

  static Future<IssuerInfo> loadIssuerDetail({required String uid}) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: '$commandPath$getIssuerInfoCommand/$uid');
    final response = await dio.getUri(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      return IssuerInfo.fromJson(res);
    } else {
      throw Exception('Failed to get issuer detail');
    }
  }

  static Future<String> getUserQRCode(String token) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getUserQRCodeCommand);
    final response = await dio.getUri(url,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    if (response.statusCode == 200) {
      String qrcode = HttpRequest._getResponseData(response);
      return qrcode;
    } else {
      throw Exception('Failed to get qrcode');
    }
  }

  static Future<NftLoadInfo> loadUserNfts(
      {String? userUid, String? pageUrl}) async {
    final url = pageUrl == null
        ? Uri(
            scheme: scheme,
            host: serverHost,
            path: commandPath + getUserNftListCommand,
            queryParameters: userUid == null ? null : {'user_uid': userUid})
        : Uri.parse(pageUrl);
    final response = await dio.getUri(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      final String? nextPageUrl = res['next_page_url'];
      List<NftInfo> nfts = [];
      for (final data in res['data']) {
        nfts.add(NftInfo.fromJson(data));
      }
      return NftLoadInfo(nextPageUrl: nextPageUrl, nfts: nfts);
    } else {
      throw Exception('Failed to get NFT list');
    }
  }

  static Future<NftInfo> loadNft({required String uid}) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getUserNftListCommand,
        queryParameters: {'uid': uid});
    final response = await dio.getUri(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      if (res['data'].length > 0) {
        return NftInfo.fromJson(res['data'][0]);
      }
      throw Exception('Failed to get NFT from uid');
    } else {
      throw Exception('Failed to get NFT list');
    }
  }

  static Future<NftInfo> projectMint(String uid, String token) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: "$commandPath/activities/$uid/mint");
    final response = await dio.postUri(url,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      return NftInfo.fromJson(res);
    } else {
      throw Exception('Failed to mint');
    }
  }

  Future<bool> logout() async {
    final uri = Uri(
        scheme: scheme, host: serverHost, path: commandPath + logoutCommand);
    final response = await dio.deleteUri(uri,
        options: Options(headers: {
          'Authorization': 'Bearer ${DataStorage.getToken() ?? ''}'
        }));
    if (response.statusCode == 200) {
      AuthService.to.logout();
      return true;
    } else {
      throw Exception('Failed to logout');
    }
  }

  Future<UserInfo> updateUsername(String username) async {
    final uri = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + updateUserInfoCommand);
    final data = {"nickname": username};
    final headers = {'Authorization': 'Bearer ${DataStorage.getToken() ?? ''}'};
    final response =
        await dio.postUri(uri, data: data, options: Options(headers: headers));
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      UserInfo userInfo = UserInfo.fromJson(res);
      Global.userInfo = userInfo;
      return userInfo;
    } else {
      throw Exception('Failed to update username');
    }
  }

  Future<FaceInfo?> uploadFacePhoto(List<int> bytes, String filename) async {
    final uri = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + uploadFacePhotoCommand);
    final headers = {'Authorization': 'Bearer ${DataStorage.getToken() ?? ''}'};
    final formData = FormData.fromMap({
      "face": MultipartFile.fromBytes(bytes,
          filename: "file.jpg", contentType: MediaType("image", "jpeg"))
    });
    final response = await dio.postUri(uri,
        data: formData, options: Options(headers: headers));
    if (response.statusCode == 200) {
      try {
        final res = HttpRequest._getResponseData(response);
        FaceInfo faceInfo = FaceInfo.fromJson(res);
        return faceInfo;
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Activity> getActivity(String activityId) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getProjectCommand.replaceFirst("@", activityId),
        queryParameters: {'uid': activityId});
    final headers = {'Authorization': 'Bearer ${DataStorage.getToken() ?? ''}'};
    final response = await dio.getUri(url, options: Options(headers: headers));
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      Activity activity = Activity.fromJson(res);
      return activity;
    } else {
      throw Exception('Failed to get activity');
    }
  }

  Future<RegistrationInfo> getRegistrationInfo(String ID) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getRegistrationInfoCommand.replaceFirst("@", ID),
        queryParameters: {'uid': ID});
    final headers = {'Authorization': 'Bearer ${DataStorage.getToken() ?? ''}'};
    final response = await dio.getUri(url, options: Options(headers: headers));
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      RegistrationInfo registrationInfo = RegistrationInfo.fromJson(res);
      return registrationInfo;
    } else {
      throw Exception('Failed to getRegistrationInfo');
    }
  }

  Future<bool> updateRegistrationInfo(
      String ID, String number, bool isUpdate) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + updateRegistrationInfoCommand.replaceFirst("@", ID),
        queryParameters: {
          'uid': ID,
          'number': number,
          'action': isUpdate ? 'update' : 'create'
        });
    final headers = {'Authorization': 'Bearer ${DataStorage.getToken() ?? ''}'};
    final response = await dio.postUri(url, options: Options(headers: headers));
    if (response.statusCode == 200) {
      final Map<String, dynamic> object = response.data;
      final String status = object['status'];
      if (status == 'success') {
        return true;
      } else {
        final int errorCode = object['err_code'];
        final String errorMessage = object['err_msg'];
        MessageToast.showException(errorMessage);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<ShareInfo> getProjectDetailsShareInfo(String ID) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getShareInfoCommand.replaceFirst("@", ID),
        queryParameters: {
          'uid': ID,
        });
    final headers = {'Authorization': 'Bearer ${DataStorage.getToken() ?? ''}'};
    final response = await dio.getUri(url, options: Options(headers: headers));
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      ShareInfo shareInfo = ShareInfo.fromJson(res);
      return shareInfo;
    } else {
      throw Exception('Failed to getShareInfo');
    }
  }

  Future<ShareInfo> getNFTDetailsShareInfo(String ID) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getNFTShareInfoCommand.replaceFirst("@", ID),
        queryParameters: {
          'uid': ID,
        });
    final headers = {'Authorization': 'Bearer ${DataStorage.getToken() ?? ''}'};
    final response = await dio.getUri(url, options: Options(headers: headers));
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      ShareInfo shareInfo = ShareInfo.fromJson(res);
      return shareInfo;
    } else {
      throw Exception('Failed to getNFTShareInfo');
    }
  }

  Future<WechatConfig> getWechatConfig(String url, List<String> APIs) async {
    final uri = Uri(
      scheme: scheme,
      host: serverHost,
      path: commandPath + getWechatConfigCommand,
      queryParameters: {
        'url': url,
        'api_list[]': APIs,
      },
    );
    final response = await dio.postUri(uri);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      WechatConfig config = WechatConfig.fromJson(res);
      return config;
    } else {
      throw Exception('Failed to getWechatConfig');
    }
  }
}
