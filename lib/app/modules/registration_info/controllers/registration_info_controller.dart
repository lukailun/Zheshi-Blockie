// Package imports:
import 'package:blockie_app/app/routes/app_router.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/widgets/basic_two_button_dialog.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'registration_info_controller_router.dart';

class RegistrationInfoController extends GetxController {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;

  final initialEntryNumber = ''.obs;
  final newEntryNumber = ''.obs;
  bool isUpdate = false;
  final faceInfos = <FaceInfo>[].obs;
  final exampleNumber = ''.obs;

  final id = Get.parameters[RegistrationInfoParameter.id] as String;

  RegistrationInfoController({
    required this.accountRepository,
    required this.projectRepository,
  });

  @override
  void onReady() {
    super.onReady();
    getRegistrationInfo();
  }

  bool saveButtonIsEnabled() {
    final notEmpty = newEntryNumber.value.isNotEmpty;
    final notSame = newEntryNumber.value != initialEntryNumber.value;
    return notEmpty && notSame;
  }

  void updateRegistrationInfo() async {
    final isSuccessful = await projectRepository.updateRegistrationInfo(
        id, newEntryNumber.value, isUpdate);
    if (isSuccessful) {
      MessageToast.showMessage("保存成功");
      getRegistrationInfo();
    }
  }

  void getRegistrationInfo() async {
    final registrationInfo = await projectRepository.getRegistrationInfo(id);
    if (registrationInfo == null) {
      return;
    }
    initialEntryNumber.value = registrationInfo.entryNumber;
    faceInfos.value = registrationInfo.faceInfos;
    exampleNumber.value = registrationInfo.exampleNumber;
    isUpdate = registrationInfo.hasSigned;
  }

  void deleteFacePhoto(String faceID) async {
    final isSuccessful = await accountRepository.deleteFacePhoto(faceID);
    if (isSuccessful) {
      MessageToast.showMessage("删除成功");
      getRegistrationInfo();
    }
  }
}

class RegistrationInfoParameter {
  static const id = 'id';
}
