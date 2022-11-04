// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/models/user_info.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class UpdateBioController extends GetxController {
  final ProfileRepository repository;
  final initialBio = (AuthService.to.user.value?.bio ?? "").obs;
  final newBio = ''.obs;

  UpdateBioController({required this.repository});

  @override
  void onReady() {
    super.onReady();
    newBio.value = initialBio.value;
  }

  bool saveButtonIsEnabled() {
    final notEmpty = newBio.value.isNotEmpty;
    final notSame = newBio.value != initialBio.value;
    return notEmpty && notSame;
  }

  void updateBio(String bio) async {
    final userInfo = await repository.updateBio(bio);
    if (userInfo == null) {
      return;
    }
    initialBio.value = userInfo.bio ?? '';
    newBio.value = userInfo.bio ?? '';
    final userValue = AuthService.to.user.value;
    AuthService.to.user.value = UserInfo(
      username: userInfo.username,
      avatarPath: userInfo.avatarPath,
      phoneNumber: userInfo.phoneNumber,
      level: userInfo.level,
      id: userInfo.id,
      wallets: userValue?.wallets,
      roles: userValue?.roles,
      bio: userValue?.bio,
    );
    MessageToast.showMessage('修改成功');
  }
}
