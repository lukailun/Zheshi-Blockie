import 'dart:convert';
import 'package:blockie_app/common/project_group.dart';
import 'package:blockie_app/common/project_group_load_info.dart';
import 'package:http/http.dart' as http;
import 'package:blockie_app/common/global.dart';
import 'package:blockie_app/common/user_info.dart';
import 'package:blockie_app/common/project_info.dart';
import 'package:blockie_app/common/project_detail_info.dart';
import 'package:blockie_app/common/nft_info.dart';
import 'package:blockie_app/common/nft_load_info.dart';
import 'package:blockie_app/common/project_load_info.dart';
import 'package:blockie_app/common/project_group_load_info.dart';

const scheme = "https";
const serverHost = "s.blockie.zheshi.tech";
const commandPath = "/api/v1";
const loginCommand = "/login";
const getUserInfoCommand = "/user";
const getProjectsCommand = "/activities";
const getUserQRCodeCommand = "/qrcode";
const getUserNftListCommand = "/NFTs";


class HttpRequest{
  static dynamic _getResponseData(http.Response response) {
    final res = jsonDecode(utf8.decode(response.bodyBytes));
    String status = res['status'];
    if (status == 'success') {
      return res['data'];
    } else if (status == 'error') {
      throw Exception(res['err_msg']);
    }
  }

  static Future<String> login(String code) async {
    final url = Uri(
      scheme: scheme,
      host: serverHost,
      path: commandPath + loginCommand
    );
    final data = {'code': code};
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      return res['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<UserInfo> getUserInfo(String token) async {
    if (Global.userInfo != null) {
      return Global.userInfo!;
    }
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getUserInfoCommand
    );
    final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      UserInfo userInfo = UserInfo.fromJson(res);
      Global.userInfo = userInfo;
      return userInfo;
    } else {
      throw Exception('Failed to get user info');
    }
  }

  static Future<ProjectLoadInfo> loadBrandProjects({String? pageUrl, String? issuerUid}) async {
    final url = pageUrl == null ? Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getProjectsCommand,
        queryParameters: {'issuer_uid': issuerUid}
    ) : Uri.parse(pageUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      String? nextPageUrl = res['next_page_url'];
      List<ProjectInfo> projects = [];
      for (final data in res['data']) {
        projects.add(ProjectInfo.fromJson(data));
      }
      return ProjectLoadInfo(nextPageUrl: nextPageUrl, projects: projects);
    } else {
      throw Exception('Failed to get projects');
    }
  }

  static Future<ProjectGroupLoadInfo> loadProjectGroups({String? pageUrl}) async {
    final url = pageUrl == null ? Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getProjectsCommand
    ) : Uri.parse(pageUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      String? nextPageUrl = res['next_page_url'];
      List<ProjectGroup> projectGroups = [];
      for (final data in res['data']) {
        projectGroups.add(ProjectGroup.fromJson(data));
      }
      return ProjectGroupLoadInfo(nextPageUrl: nextPageUrl, projectGroups: projectGroups);
    } else {
      throw Exception('Failed to get project groups');
    }
  }

  static Future<ProjectDetailInfo> loadProjectDetail({String? uid, String? issuerUid, String? token}) async {
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
        path: '$commandPath$getProjectsCommand/$projectUid'
    );
    final response = token == null ? await http.get(url) : await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      return ProjectDetailInfo.fromJson(res);
    } else {
      throw Exception('Failed to get project detail');
    }
  }

  static Future<String> getUserQRCode(String token) async {
    final url = Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getUserQRCodeCommand
    );
    final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      String qrcode = HttpRequest._getResponseData(response);
      return qrcode;
    } else {
      throw Exception('Failed to get qrcode');
    }
  }

  static Future<NftLoadInfo> loadUserNfts({String? userUid, String? pageUrl}) async {
    final url = pageUrl == null ? Uri(
        scheme: scheme,
        host: serverHost,
        path: commandPath + getUserNftListCommand,
        queryParameters: userUid == null ? null : {'user_uid': userUid}
    ) : Uri.parse(pageUrl);
    final response = await http.get(url);
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
        queryParameters: {'uid': uid}
    );
    final response = await http.get(url);
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
        path: "$commandPath/activities/$uid/mint"
    );
    final response = await http.post(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final res = HttpRequest._getResponseData(response);
      return NftInfo.fromJson(res);
    } else {
      throw Exception('Failed to mint');
    }
  }
}
