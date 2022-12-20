part of 'developer_mode_controller.dart';

extension DeveloperModeControllerRouter on DeveloperModeController {
  void goToHttpLog() {
    AppRouter.to(HttpLogListWidget());
  }
}
