// Package imports:
import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:http_parser/http_parser.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/models/paginated_activities.dart';
import 'package:blockie_app/app/modules/activity/models/activity.dart';
import 'package:blockie_app/app/modules/add_whitelist/models/add_whitelist_details.dart';
import 'package:blockie_app/app/modules/airdrop_nft/models/airdrop_nft_details.dart';
import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/app/modules/hold_verification/models/hold_verification_details.dart';
import 'package:blockie_app/app/modules/profile/models/profile.dart';
import 'package:blockie_app/app/modules/profile/models/profile_label.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';
import 'package:blockie_app/app/modules/registration_info/models/registration_info.dart';
import 'package:blockie_app/app/modules/share/models/share_info.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/ticket_checking_details.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/data/apis/models/exceptions.dart';
import 'package:blockie_app/data/apis/models/wechat_config.dart';
import 'package:blockie_app/models/global.dart';
import 'package:blockie_app/models/nft_info.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'blockie_api_account.dart';

part 'blockie_api_profile.dart';

part 'blockie_api_project.dart';

part 'blockie_api_projects_management.dart';

typedef UserTokenSupplier = String? Function();

class BlockieApi {
  BlockieApi({
    required UserTokenSupplier userTokenSupplier,
  })  : _dio = Dio(),
        _urlBuilder = BlockieUrlBuilder() {
    _dio.setUpAuthHeaders(userTokenSupplier);
    _dio.interceptors.add(DioLogInterceptor());
  }

  final Dio _dio;
  final BlockieUrlBuilder _urlBuilder;

  Future<ProjectDetails?> getProjectDetails(String id) async {
    final url = _urlBuilder.buildGetProjectDetailsUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final projectDetails = ProjectDetails.fromJson(object);
      return projectDetails;
    } catch (error) {
      return null;
    }
  }

  Future<NftInfo?> mint(String id) async {
    final url = _urlBuilder.buildMintUrl(id);
    final response = await _dio.post(url);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final nft = NftInfo.fromJson(object);
      return nft;
    } catch (error) {
      return null;
    }
  }

  Future<ShareInfo?> getNftDetailsShareInfo(String id) async {
    final url = _urlBuilder.buildGetNftDetailsShareInfoUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final shareInfo = ShareInfo.fromJson(object);
      return shareInfo;
    } catch (error) {
      return null;
    }
  }

  Future<ShareInfo?> getProjectDetailsShareInfo(String id) async {
    final url = _urlBuilder.buildGetProjectDetailsShareInfoUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final shareInfo = ShareInfo.fromJson(object);
      return shareInfo;
    } catch (error) {
      return null;
    }
  }

  Future<RegistrationInfo?> getRegistrationInfo(String id) async {
    final url = _urlBuilder.buildGetRegistrationInfoUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final registrationInfo = RegistrationInfo.fromJson(object);
      return registrationInfo;
    } catch (error) {
      return null;
    }
  }

  Future<bool> updateRegistrationInfo(
      String id, String number, bool isUpdate) async {
    final url = _urlBuilder.buildUpdateRegistrationInfoUrl(id);

    final requestData = {
      'number': number,
      'action': isUpdate ? 'update' : 'create',
    };
    final response = await _dio.post(url, data: requestData);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final registrationInfo = RegistrationInfo.fromJson(object);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<Activity?> getActivity(String id) async {
    final url = _urlBuilder.buildGetActivityUrl(id);
    final response = await _dio.get(url);
    try {
      final Map<String, dynamic> object = _getResponseData(response);
      final activity = Activity.fromJson(object);
      return activity;
    } catch (error) {
      return null;
    }
  }

  static const _errorCodeJsonKey = 'err_code';
  static const _errorMessageJsonKey = 'err_msg';

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
