// Package imports:
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

// Project imports:
import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/data/apis/models/exceptions.dart';
import 'package:blockie_app/data/apis/models/wechat_config.dart';
import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

typedef UserTokenSupplier = String? Function();

class BlockieAPI {
  static const _errorCodeJsonKey = 'err_code';
  static const _errorMessageJsonKey = 'err_msg';

  BlockieAPI({
    required UserTokenSupplier userTokenSupplier,
  })  : _dio = Dio(),
        _urlBuilder = const BlockieUrlBuilder() {
    _dio.setUpAuthHeaders(userTokenSupplier);
    _dio.interceptors.add(
      LogInterceptor(responseBody: false),
    );
  }

  final Dio _dio;
  final BlockieUrlBuilder _urlBuilder;

  Future<bool> logout() async {
    final url = _urlBuilder.buildLogoutUrl();
    final response = await _dio.delete(url);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      AuthService.to.logout();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<UserInfo?> updateUsername(String username) async {
    final url = _urlBuilder.buildUpdateUserInfoUrl();
    final requestData = {
      "nickname": username,
    };
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final userInfo = UserInfo.fromJson(object);
      Global.userInfo = userInfo;
      return userInfo;
    } catch (error) {
      return null;
    }
  }

  Future<FaceInfo?> uploadFacePhoto(List<int> bytes, String filename) async {
    final url = _urlBuilder.buildUploadFacePhotoUrl();
    final requestData = FormData.fromMap({
      "face": MultipartFile.fromBytes(bytes,
          filename: "face.jpg", contentType: MediaType("image", "jpeg"))
    });
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      FaceInfo faceInfo = FaceInfo.fromJson(object);
      return faceInfo;
    } catch (error) {
      return null;
    }
  }

  Future<bool> deleteFacePhoto(String faceID) async {
    final url = _urlBuilder.buildDeleteFacePhotoUrl(faceID);
    final response = await _dio.delete(url);
    final Map<String, dynamic> object = response.data;
    final String status = object['status'];
    if (status == 'error') {
      return false;
    }
    return true;
  }

  Future<WechatConfig?> getWechatConfig(
      String supportedUrl, List<String> APIs) async {
    final url = _urlBuilder.buildGetWechatConfigUrl();
    final requestData = {
      'url': supportedUrl,
      'api_list': APIs,
    };
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final config = WechatConfig.fromJson(object);
      return config;
    } catch (error) {
      return null;
    }
  }

  static dynamic _getResponseData(Response response) {
    if (response.statusCode != 200) {
      throw NetworkException();
    }
    final Map<String, dynamic> object = response.data;
    final String status = object['status'];
    if (status == 'success') {
      return object['data'];
    } else if (status == 'error') {
      final int errorCode = object[_errorCodeJsonKey];
      final String errorMessage = object[_errorMessageJsonKey];
      MessageToast.showException(errorMessage);
      throw UploadFacePhotoNotCenteredBlockieException();
    }
  }
}

extension on Dio {
  void setUpAuthHeaders(UserTokenSupplier userTokenSupplier) {
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final userToken = userTokenSupplier();
          if (userToken != null) {
            options.headers.addAll({
              'Authorization': 'Bearer $userToken',
            });
          }
          return handler.next(options);
        },
      ),
    );
  }
}
