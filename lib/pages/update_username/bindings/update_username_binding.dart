import 'package:get/get.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/utils/http_request.dart';
import '../controllers/update_username_controller.dart';

class UpdateUsernameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateUsernameController(
        repository: AccountRepository(client: HttpRequest())));
  }
}
