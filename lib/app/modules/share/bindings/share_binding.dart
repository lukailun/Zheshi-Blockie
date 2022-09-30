import 'package:get/get.dart';
import 'package:blockie_app/app/modules/share/controllers/share_controller.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/utils/http_request.dart';

class ShareBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        ShareController(repository: ProjectRepository(client: HttpRequest())));
  }
}
