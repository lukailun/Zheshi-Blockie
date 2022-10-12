import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/utils/http_request.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/event/controllers/event_controller.dart';

class EventBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        EventController(repository: ProjectRepository(client: HttpRequest())));
  }
}
