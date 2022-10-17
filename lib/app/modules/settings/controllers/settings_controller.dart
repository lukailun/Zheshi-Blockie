// Dart imports:
import 'dart:html' as html;
import 'dart:ui' as ui;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/web_view/controllers/web_view_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/apis/blockie_url_builder.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/extensions/extensions.dart';
import 'package:blockie_app/services/anyweb_service.dart';
import 'package:blockie_app/services/auth_service.dart';

class SettingsController extends GetxController {
  final AccountRepository repository;
  final initialPhoneNumber = (AuthService.to.userInfo.value?.phone ?? "").obs;
  final isLoggingOut = false.obs;

  SettingsController({required this.repository});

  @override
  void onInit() {
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(AnyWebMethod.logout.value, (_) {
      return html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src =
            'https://zheshi.tech/public/dist/?method=${AnyWebMethod.logout.value}'
        ..style.border = 'none';
    });

    AnyWebService.to.logout.listen((_) {
      isLoggingOut.value = false;
      logout();
    });
    super.onInit();
  }

  String displayPhoneNumber(String phone) {
    if (phone.length != 11) {
      return phone;
    }
    return "${phone.substring(0, 3)}****${phone.substring(phone.length - 4)}";
  }

  void logout() {
    repository.logout().then((isSuccessful) {
      Get.offAllNamed(Routes.initial);
    });
  }

  void goToTermsOfService() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildTermsOfServiceUrl(),
    };
    Get.toNamedWithJsonParameters(Routes.webView, parameters: parameters);
  }

  void goToPrivacyPolicy() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildPrivacyPolicyUrl(),
    };
    Get.toNamedWithJsonParameters(Routes.webView, parameters: parameters);
  }
}
