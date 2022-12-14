part of 'face_verification_controller.dart';

extension FaceVerificationControllerRouter on FaceVerificationController {
  void goToTermsOfService() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildTermsOfServiceUrl(),
    };
    AppRouter.toNamed(Routes.webView, parameters: parameters);
  }

  void goToPrivacyPolicy() {
    final parameters = {
      WebViewParameter.url: BlockieUrlBuilder.buildPrivacyPolicyUrl(),
    };
    AppRouter.toNamed(Routes.webView, parameters: parameters);
  }
}
