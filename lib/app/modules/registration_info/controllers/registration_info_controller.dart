import 'package:blockie_app/app/routes/app_pages.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/widgets/message_toast.dart';
import 'package:get/get.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';

class RegistrationInfoController extends GetxController {
  final AccountRepository accountRepository;
  final ProjectRepository projectRepository;

  final initialEntryNumber = ''.obs;
  final newEntryNumber = ''.obs;
  bool isUpdate = false;
  final facePaths = <String>[].obs;

  final _ID = Get.parameters[RegistrationInfoParameter.ID] ?? "";

  RegistrationInfoController({
    required this.accountRepository,
    required this.projectRepository,
  });

  @override
  void onInit() {
    super.onInit();
    _getRegistrationInfo();
  }

  bool saveButtonIsEnabled() {
    final notEmpty = newEntryNumber.value.isNotEmpty;
    final notSame = newEntryNumber.value != initialEntryNumber.value;
    return notEmpty && notSame;
  }

  void updateRegistrationInfo() async {
    final isSuccessful = await projectRepository.updateRegistrationInfo(
        _ID, newEntryNumber.value, isUpdate);
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
    final registrationInfo = await projectRepository.getRegistrationInfo(_ID);
    initialEntryNumber.value = registrationInfo.entryNumber;
    newEntryNumber.value = registrationInfo.entryNumber;
    facePaths.value = registrationInfo.faceInfos.map((it) => it.path).toList();
    isUpdate = registrationInfo.hasSigned;
  }
}

class RegistrationInfoParameter {
  static const ID = "ID";
}
