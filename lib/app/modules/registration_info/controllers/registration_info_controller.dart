// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/face_verification/models/face_info.dart';
import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/widgets/message_toast.dart';

class RegistrationInfoController extends GetxController {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;

  final initialEntryNumber = ''.obs;
  final newEntryNumber = ''.obs;
  bool isUpdate = false;
  final faceInfos = <FaceInfo>[].obs;
  final exampleNumber = ''.obs;

  final _id = Get.parameters[RegistrationInfoParameter.id] as String;

  RegistrationInfoController({
    required this.accountRepository,
    required this.projectRepository,
  });

  @override
  void onReady() {
    super.onReady();
    _getRegistrationInfo();
  }

  bool saveButtonIsEnabled() {
    final notEmpty = newEntryNumber.value.isNotEmpty;
    final notSame = newEntryNumber.value != initialEntryNumber.value;
    return notEmpty && notSame;
  }

  void updateRegistrationInfo() async {
    final isSuccessful = await projectRepository.updateRegistrationInfo(
        _id, newEntryNumber.value, isUpdate);
    if (isSuccessful) {
      MessageToast.showMessage("保存成功");
      _getRegistrationInfo();
    }
  }

  void goToFaceVerification() async {
    final needUpdate = await Get.toNamed(Routes.faceVerification);
    if (needUpdate == true) {
      _getRegistrationInfo();
    }
  }

  void _getRegistrationInfo() async {
    final registrationInfo = await projectRepository.getRegistrationInfo(_id);
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
      _getRegistrationInfo();
    }
  }
}

class RegistrationInfoParameter {
  static const id = "id";
}
