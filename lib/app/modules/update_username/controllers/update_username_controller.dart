// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'update_username_controller_router.dart';

class UpdateUsernameController extends GetxController {
  final AccountRepository accountRepository;
  final initialName = (AuthService.to.userInfo.value?.username ?? "").obs;
  final newName = ''.obs;

  UpdateUsernameController({
    required this.accountRepository,
  });

  @override
  void onReady() {
    super.onReady();
    newName.value = initialName.value;
  }

  bool saveButtonIsEnabled() {
    final notEmpty = newName.value.isNotEmpty;
    final notSame = newName.value != initialName.value;
    final inLengthLimit = newName.value.length <= 15;
    return notEmpty && notSame && inLengthLimit;
  }

  void updateUsername(String username) async {
    final userInfo = await accountRepository.updateUsername(username);
    if (userInfo == null) {
      return;
    }
    initialName.value = userInfo.username;
    newName.value = userInfo.username;
    AuthService.to.updateUserInfo();
    MessageToast.showMessage('修改成功');
  }
}
