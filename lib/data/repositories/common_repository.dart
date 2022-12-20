// Project imports:
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';
import 'package:blockie_app/data/models/reverse_address/reverse_address.dart';
import 'package:blockie_app/data/models/wechat_config.dart';
import 'package:blockie_app/data/models/wechat_mini_program_code.dart';

class CommonRepository {
  final BlockieApi remoteApi;

  CommonRepository({required this.remoteApi});

  Future<WechatConfig?> getWechatConfig(
          String supportedUrl, List<String> apis, List<String> openTags) =>
      remoteApi.getWechatConfig(supportedUrl, apis, openTags);

  Future<ReverseAddress?> reverseAddressLookup(
          String latitude, String longitude) =>
      remoteApi.reverseAddressLookup(latitude, longitude);

  Future<WechatMiniProgramCode?> getWechatMiniProgramCode(String id) =>
      remoteApi.getWechatMiniProgramCode(id);
}
