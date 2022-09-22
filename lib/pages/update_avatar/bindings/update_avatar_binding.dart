import 'package:get/get.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/utils/http_request.dart';
import '../controllers/update_avatar_controller.dart';

class UpdateAvatarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateAvatarController(
        repository: AccountRepository(client: HttpRequest())));
  }
}
