// Package imports:
import 'package:blockie_app/app/routes/app_router.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:blockie_app/app/modules/settings/views/logout_dialog.dart';
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_url_builder.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/utils/data_storage.dart';
import 'package:blockie_app/widgets/basic_two_button_dialog.dart';

part 'settings_controller_router.dart';

class SettingsController extends GetxController {
  final AccountRepository repository;
  final user = AuthService.to.userInfo;
  final initialPhoneNumber =
      (AuthService.to.userInfo.value?.phoneNumber ?? "").obs;
  final version = ''.obs;

  SettingsController({required this.repository});

  @override
  void onReady() {
    super.onReady();
    getVersion();
  }

  String displayPhoneNumber(String phone) {
    if (phone.length != 11) {
      return phone;
    }
    return "${phone.substring(0, 3)}****${phone.substring(phone.length - 4)}";
  }

  void getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }
}
