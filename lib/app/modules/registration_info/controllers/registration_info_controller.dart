import 'package:blockie_app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

import '../../../routes/app_pages.dart';

class RegistrationInfoController extends GetxController {
  final AccountRepository repository;
  final initialName = (AuthService.to.userInfo.value?.nickname ?? "").obs;
  final entryNumber = ''.obs;

  RegistrationInfoController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    entryNumber.value = initialName.value;
  }

  bool saveButtonIsEnabled() {
    final notEmpty = entryNumber.value.isNotEmpty;
    return notEmpty;
  }

  void updateUsername(String username) {
    // repository.updateUsername(username).then((userInfo) {
    //   initialName.value = userInfo.nickname;
    //   newName.value = userInfo.nickname;
    //   AuthService.to.updateUserInfo(userInfo);
    //   MessageToast.showMessage('修改成功');
    // });
  }
}
