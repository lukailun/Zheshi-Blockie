// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:blockie_app/data/models/environment.dart';
import 'package:blockie_app/data/models/nft_info.dart';

const scheme = "https";
final serverHost = Environment.serverHost;
const commandPath = "/api/v1";
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
