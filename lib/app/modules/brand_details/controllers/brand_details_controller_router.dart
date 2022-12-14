part of 'brand_details_controller.dart';

extension BrandDetailsControllerRouter on BrandDetailsController {
  void goToActivity(String id) {
    final parameters = {ActivityParameter.id: id};
    AppRouter.toNamed(Routes.activity, parameters: parameters);
  }
}
