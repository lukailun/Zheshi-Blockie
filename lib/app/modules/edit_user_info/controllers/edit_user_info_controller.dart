import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:get/get.dart';

part 'edit_user_info_controller_router.dart';

class EditUserInfoController extends GetxController {
  final AccountRepository accountRepository;

  EditUserInfoController({
    required this.accountRepository,
  });

  final userInfo = AuthService.to.userInfo;
}
