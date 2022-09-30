import 'package:blockie_app/app/modules/face_verification/views/face_verification_view.dart';
import 'package:blockie_app/app/modules/face_verification/bindings/face_verification_binding.dart';
import 'package:blockie_app/app/modules/event/views/event_view.dart';
import 'package:blockie_app/app/modules/event/bindings/event_binding.dart';
import 'package:blockie_app/app/modules/registration_info/views/registration_info_view.dart';
import 'package:blockie_app/app/modules/settings/bindings/settings_binding.dart';
import 'package:blockie_app/app/modules/share/views/share_view.dart';
import 'package:blockie_app/app/modules/share/bindings/share_binding.dart';
import 'package:blockie_app/app/modules/update_username/views/update_username_view.dart';
import 'package:blockie_app/app/modules/update_username/bindings/update_username_binding.dart';
import 'package:blockie_app/app/modules/update_avatar/views/update_avatar_view.dart';
import 'package:blockie_app/app/modules/update_avatar/bindings/update_avatar_binding.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/brand_detail.dart';
import 'package:blockie_app/app/modules/image_view.dart';
import 'package:blockie_app/app/modules/nft_detail.dart';
import 'package:blockie_app/app/modules/project_detail.dart';
import 'package:blockie_app/app/modules/project_groups.dart';
import 'package:blockie_app/app/modules/registration_info/bindings/registration_info_binding.dart';
import 'package:blockie_app/app/modules/settings/views/settings_view.dart';
import 'package:blockie_app/app/modules/user.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
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
      page: () => const ProjectDetailsPage(),
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
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.updateName,
      page: () => const UpdateUsernameView(),
      binding: UpdateUsernameBinding(),
    ),
    GetPage(
      name: Routes.updateAvatar,
      page: () => const UpdateAvatarView(),
      binding: UpdateAvatarBinding(),
    ),
    GetPage(
      name: Routes.registrationInfo,
      page: () => const RegistrationInfoView(),
      binding: RegistrationInfoBinding(),
    ),
    GetPage(
      name: Routes.faceVerification,
      page: () => FaceVerificationView(),
      binding: FaceVerificationBinding(),
    ),
    GetPage(
      name: Routes.event,
      page: () => const EventContainerView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: Routes.share,
      page: () => const ShareView(),
      binding: ShareBinding(),
    ),
  ];
}
