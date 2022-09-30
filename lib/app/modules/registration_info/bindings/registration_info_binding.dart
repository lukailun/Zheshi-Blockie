import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:get/get.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/utils/http_request.dart';
import '../controllers/registration_info_controller.dart';

class RegistrationInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegistrationInfoController(
        accountRepository: AccountRepository(client: HttpRequest()),
        projectRepository: ProjectRepository(client: HttpRequest()),
      ),
    );
  }
}
