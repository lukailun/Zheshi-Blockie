// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:blockie_app/models/environment.dart';
import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/issuer_info.dart';
import 'package:blockie_app/models/nft_info.dart';
import 'package:blockie_app/models/nft_load_info.dart';
import 'package:blockie_app/models/project_group.dart';
import 'package:blockie_app/models/project_group_load_info.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';

const scheme = "https";
final serverHost = Environment.serverHost;
const commandPath = "/api/v1";
const loginCommand = "/login";
const getUserInfoCommand = "/user";
const getOtherUserInfoCommand = "/users";
const getProjectsCommand = "/activities";
const getIssuerInfoCommand = "/issuers";
const getUserQRCodeCommand = "/qrcode";
const getUserNftListCommand = "/NFTs";

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
}
