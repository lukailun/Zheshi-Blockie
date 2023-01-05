// Package imports:
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/services/auth_service.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (!AuthService.to.isLoggedIn) {
      const newRoute = Routes.activities;
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (AuthService.to.isLoggedIn) {
      const newRoute = Routes.activities;
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}
