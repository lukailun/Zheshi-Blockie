import 'package:get/get.dart';

import '../../../data/repositories/account_repository.dart';
import '../../../services/auth_service.dart';

class UpdateAvatarController extends GetxController {
  final AccountRepository repository;
  final initialAvatar = (AuthService.to.userInfo.value?.avatar ?? "").obs;

  UpdateAvatarController({required this.repository});
}
