import 'package:blockie_app/app/modules/event/models/event.dart';
import 'package:blockie_app/app/modules/registration_info/controllers/registration_info_controller.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final ProjectRepository repository;
  final event = Rxn<Event>();

  EventController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    _getEvent();
  }

  void goToRegistrationInfo() {
    Get.toNamed(
        "${Routes.registrationInfo}?${RegistrationInfoParameter.ID}=${event.value?.steps[2].ID ?? ""}");
  }

  void _getEvent() async {
    event.value = await repository.getEvent(Get.parameters["groupUid"] ?? "");
  }
}
