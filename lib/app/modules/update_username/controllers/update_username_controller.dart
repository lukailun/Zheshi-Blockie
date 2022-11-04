// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class UpdateUsernameController extends GetxController {
  final ProfileRepository repository;
  final initialName = (AuthService.to.user.value?.username ?? "").obs;
  final newName = ''.obs;

  UpdateUsernameController({required this.repository});

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
    final userInfo = await repository.updateUsername(username);
    if (userInfo == null) {
      return;
    }
    initialName.value = userInfo.username;
    newName.value = userInfo.username;
    AuthService.to.updateUserInfo();
    MessageToast.showMessage('修改成功');
  }
}
