// Dart imports:
import 'dart:js' as js;

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/services/auth_service.dart';
import 'package:blockie_app/services/wechat_service/wechat_js_sdk/wechat_js_sdk.dart';
import 'package:blockie_app/widgets/loading_indicator.dart';
import 'package:blockie_app/widgets/message_toast.dart';

part 'update_avatar_controller_router.dart';

class UpdateAvatarController extends GetxController {
  final AccountRepository accountRepository;
  final initialAvatar = (AuthService.to.userInfo.value?.avatarUrl ?? '').obs;
  final selectedAvatarData = ''.obs;

  UpdateAvatarController({required this.accountRepository});

  void chooseImage() {
    wechatChooseImage(
      WechatChooseImageParams(
        count: 1,
        sizeType: ['original', 'compressed'],
        sourceType: ['album', 'camera'],
        success: js.allowInterop(
          (result) {
            final localIds = result.localIds ?? [];
            if (localIds.isEmpty) {
              return;
            }
            getLocalImageData(localIds.first);
          },
        ),
      ),
    );
  }

  void getLocalImageData(String localId) {
    wechatGetLocalImageData(
      WechatGetLocalImageDataParams(
        localId: localId,
        success: js.allowInterop(
          (result) {
            final localData = result.localData ?? '';
            if (localData.isEmpty) {
              return;
            }
            final imageData =
                localData.replaceAll('data:image/jpg;base64,', '');
            selectedAvatarData.value = 'data:image/jpg;base64,$imageData';
          },
        ),
      ),
    );
  }

  void updateAvatar() async {
    final data =
        selectedAvatarData.value.replaceAll('data:image/jpg;base64,', '');
    if (data.isEmpty) {
      return;
    }
    Get.loadingIndicatorDialog();
    final userInfo = await accountRepository.updateAvatar(data);
    Get.back();
    if (userInfo == null) {
      return;
    }
    AuthService.to.updateUserInfo(callback: () {
      initialAvatar.value = AuthService.to.userInfo.value?.avatarUrl ?? '';
      selectedAvatarData.value = '';
      MessageToast.showMessage('修改成功');
    });
  }
}
