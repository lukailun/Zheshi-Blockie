import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/account_repository.dart';

class UpdateUsernameController extends GetxController {
  final AccountRepository repository;
  final textEditingController = TextEditingController();
  final initialName = (AuthService.to.userInfo.value?.nickname ?? "").obs;
  final newName = ''.obs;

  UpdateUsernameController({required this.repository});

  @override
  void onInit() {
    textEditingController.text = initialName.value;
    textEditingController.addListener(() {
      newName.value = textEditingController.text;
    });
    newName.value = initialName.value;
    super.onInit();
  }

  bool saveButtonIsEnabled() {
    final notEmpty = newName.value.isNotEmpty;
    final notSame = newName.value != initialName.value;
    final inLengthLimit = newName.value.length <= 15;
    return notEmpty && notSame && inLengthLimit;
  }

  void updateUsername(String username) {
    repository.updateUsername(username).then((userInfo) {
      initialName.value = userInfo.nickname;
      newName.value = userInfo.nickname;
      AuthService.to.updateUserInfo(userInfo);
      MessageToast.showMessage('修改成功');
    });
  }
}
