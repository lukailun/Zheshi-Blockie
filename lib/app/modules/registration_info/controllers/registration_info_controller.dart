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
        _ID, newEntryNumber.value);
    if (isSuccessful) {
      initialEntryNumber.value = newEntryNumber.value;
      MessageToast.showMessage("保存成功");
    }
  }

  void goToFaceVerification() {
    Get.toNamed(Routes.faceVerification);
  }

  void _getRegistrationInfo() async {
    final registrationInfo = await projectRepository.getRegistrationInfo(_ID);
    initialEntryNumber.value = registrationInfo.entryNumber;
    newEntryNumber.value = registrationInfo.entryNumber;
    facePaths.value = registrationInfo.faceInfos.map((it) => it.path).toList();
  }
}

class RegistrationInfoParameter {
  static const ID = "ID";
}
