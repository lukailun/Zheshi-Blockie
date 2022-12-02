// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class UpdateBioController extends GetxController {
  final AccountRepository accountRepository;
  final initialBio = (AuthService.to.userInfo.value?.bio ?? '').obs;
  final newBio = ''.obs;

  UpdateBioController({
    required this.accountRepository,
  });

  @override
  void onReady() {
    super.onReady();
    newBio.value = initialBio.value;
  }

  bool saveButtonIsEnabled() {
    final notSame = newBio.value != initialBio.value;
    return notSame;
  }

  void updateBio(String bio) async {
    final userInfo = await accountRepository.updateBio(bio);
    if (userInfo == null) {
      return;
    }
    initialBio.value = userInfo.bio;
    newBio.value = userInfo.bio;
    AuthService.to.updateUserInfo(callback: () {
      MessageToast.showMessage('修改成功');
    });
  }
}
