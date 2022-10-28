// Package imports:
import 'package:blockie_app/models/user_info.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class UpdateUsernameController extends GetxController {
  final AccountRepository repository;
  final initialName = (AuthService.to.user.value?.nickname ?? "").obs;
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
    initialName.value = userInfo.nickname;
    newName.value = userInfo.nickname;
    final userValue = AuthService.to.user.value;
    AuthService.to.user.value = UserInfo(
      nickname: userInfo.nickname,
      avatar: userInfo.avatar,
      phone: userInfo.phone,
      level: userInfo.level,
      uid: userInfo.uid,
      walletAddress: userValue?.walletAddress,
      roles: userValue?.roles,
    );
    MessageToast.showMessage('修改成功');
  }
}
