// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/models/gender.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'update_gender_controller_router.dart';

class UpdateGenderController extends GetxController {
  final AccountRepository accountRepository;

  UpdateGenderController({
    required this.accountRepository,
  });

  final selectedGender = (AuthService.to.userInfo.value?.gender != Gender.female
          ? Gender.male
          : Gender.female)
      .obs;

  bool saveButtonIsEnabled() {
    return AuthService.to.userInfo.value?.gender != selectedGender.value;
  }

  void updateGender() async {
    final userInfo =
        await accountRepository.updateGender(selectedGender.value.value);
    if (userInfo == null) {
      return;
    }
    AuthService.to.updateUserInfo(callback: () {
      selectedGender.value =
          AuthService.to.userInfo.value?.gender != Gender.female
              ? Gender.male
              : Gender.female;
      MessageToast.showMessage('修改成功');
    });
  }
}
