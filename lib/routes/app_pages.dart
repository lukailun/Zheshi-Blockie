import 'package:blockie_app/pages/settings/bindings/settings_binding.dart';
import 'package:blockie_app/pages/update_username/views/update_username_view.dart';
import 'package:blockie_app/pages/update_username/bindings/update_username_binding.dart';
import 'package:blockie_app/pages/update_avatar/views/update_avatar_view.dart';
import 'package:blockie_app/pages/update_avatar/bindings/update_avatar_binding.dart';
import 'package:get/get.dart';
import '../pages/brand_detail.dart';
import '../pages/image_view.dart';
import '../pages/nft_detail.dart';
import '../pages/project_detail.dart';
import '../pages/project_groups.dart';
import '../pages/projects.dart';
import '../pages/settings/views/settings_view.dart';
import '../pages/user.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => const ProjectGroups(),
    ),
    GetPage(
      name: Routes.projects,
      page: () => const Projects(),
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
      name: Routes.project,
      page: () => const ProjectPage(),
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
  ];
}
