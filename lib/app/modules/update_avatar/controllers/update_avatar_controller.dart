import 'package:get/get.dart';

import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';

class UpdateAvatarController extends GetxController {
  final AccountRepository repository;
  final initialAvatar = (AuthService.to.userInfo.value?.avatar ?? "").obs;

  UpdateAvatarController({required this.repository});
}
