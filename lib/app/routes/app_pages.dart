// Dart imports:
import 'dart:io';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activity/bindings/activity_binding.dart';
import 'package:blockie_app/app/modules/activity/views/activity_view.dart';
import 'package:blockie_app/app/modules/brand_detail.dart';
import 'package:blockie_app/app/modules/face_verification/bindings/face_verification_binding.dart';
import 'package:blockie_app/app/modules/face_verification/views/face_verification_view.dart';
import 'package:blockie_app/app/modules/image_view.dart';
import 'package:blockie_app/app/modules/nft_detail.dart';
import 'package:blockie_app/app/modules/project_details/bindings/project_details_binding.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_view.dart';
import 'package:blockie_app/app/modules/project_groups.dart';
import 'package:blockie_app/app/modules/registration_info/bindings/registration_info_binding.dart';
import 'package:blockie_app/app/modules/registration_info/views/registration_info_view.dart';
import 'package:blockie_app/app/modules/settings/bindings/settings_binding.dart';
import 'package:blockie_app/app/modules/settings/views/settings_view.dart';
import 'package:blockie_app/app/modules/share/bindings/share_binding.dart';
import 'package:blockie_app/app/modules/share/views/share_view.dart';
import 'package:blockie_app/app/modules/update_avatar/bindings/update_avatar_binding.dart';
import 'package:blockie_app/app/modules/update_avatar/views/update_avatar_view.dart';
import 'package:blockie_app/app/modules/update_username/bindings/update_username_binding.dart';
import 'package:blockie_app/app/modules/update_username/views/update_username_view.dart';
import 'package:blockie_app/app/modules/user.dart';
import 'package:blockie_app/app/modules/web_view/bindings/web_view_binding.dart';
import 'package:blockie_app/app/modules/web_view/views/web_view_view.dart';
import 'package:blockie_app/data/apis/blockie_api.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/utils/http_request.dart';
import '../../utils/data_storage.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static final remoteApi = BlockieApi(
    userTokenSupplier: () => DataStorage.getToken(),
  );
  static final _accountRepository = AccountRepository(remoteApi: remoteApi);
  static final _projectRepository =
      ProjectRepository(client: HttpRequest(), remoteApi: remoteApi);

  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => const ProjectGroups(),
    ),
    GetPage(
      name: Routes.user,
      page: () => const UserPage(),
    ),
    GetPage(
      name: Routes.brand,
      page: () => const BrandPage(),
    ),
    GetPage(
      name: Routes.projectDetails,
      page: () => const ProjectDetailsContainerView(),
      binding: ProjectDetailsBinding(projectRepository: _projectRepository),
    ),
    GetPage(
      name: Routes.imageView,
      page: () => const ImageView(),
    ),
    GetPage(
      name: Routes.nft,
      page: () => const NftPage(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(accountRepository: _accountRepository),
    ),
    GetPage(
      name: Routes.updateName,
      page: () => const UpdateUsernameView(),
      binding: UpdateUsernameBinding(accountRepository: _accountRepository),
    ),
    GetPage(
      name: Routes.updateAvatar,
      page: () => const UpdateAvatarView(),
      binding: UpdateAvatarBinding(accountRepository: _accountRepository),
    ),
    GetPage(
      name: Routes.registrationInfo,
      page: () => const RegistrationInfoView(),
      binding: RegistrationInfoBinding(
        accountRepository: _accountRepository,
        projectRepository: _projectRepository,
      ),
    ),
    GetPage(
      name: Routes.faceVerification,
      page: () => FaceVerificationView(),
      binding: FaceVerificationBinding(accountRepository: _accountRepository),
    ),
    GetPage(
      name: Routes.activity,
      page: () => const ActivityContainerView(),
      binding: ActivityBinding(projectRepository: _projectRepository),
    ),
    GetPage(
      name: Routes.share,
      page: () => const ShareView(),
      binding: ShareBinding(projectRepository: _projectRepository),
    ),
    GetPage(
      name: Routes.webView,
      page: () => const WebViewView(),
      binding: WebViewBinding(),
    ),
  ];
}
