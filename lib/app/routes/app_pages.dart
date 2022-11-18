// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/app/modules/activities/bindings/activities_binding.dart';
import 'package:blockie_app/app/modules/activities/views/activities_view.dart';
import 'package:blockie_app/app/modules/activities_management/bindings/activities_management_binding.dart';
import 'package:blockie_app/app/modules/activities_management/views/activities_management_view.dart';
import 'package:blockie_app/app/modules/activity/bindings/activity_binding.dart';
import 'package:blockie_app/app/modules/activity/views/activity_view.dart';
import 'package:blockie_app/app/modules/add_whitelist/bindings/add_whitelist_binding.dart';
import 'package:blockie_app/app/modules/add_whitelist/views/add_whitelist_view.dart';
import 'package:blockie_app/app/modules/airdrop_nft/bindings/airdrop_nft_binding.dart';
import 'package:blockie_app/app/modules/airdrop_nft/views/airdrop_nft_view.dart';
import 'package:blockie_app/app/modules/brand_details/bindings/brand_details_binding.dart';
import 'package:blockie_app/app/modules/brand_details/views/brand_details_view.dart';
import 'package:blockie_app/app/modules/developer_mode/bindings/developer_mode_binding.dart';
import 'package:blockie_app/app/modules/developer_mode/views/developer_mode_view.dart';
import 'package:blockie_app/app/modules/face_verification/bindings/face_verification_binding.dart';
import 'package:blockie_app/app/modules/face_verification/views/face_verification_view.dart';
import 'package:blockie_app/app/modules/gallery/bindings/gallery_binding.dart';
import 'package:blockie_app/app/modules/gallery/views/gallery_view.dart';
import 'package:blockie_app/app/modules/hold_verification/bindings/hold_verification_binding.dart';
import 'package:blockie_app/app/modules/hold_verification/views/hold_verification_view.dart';
import 'package:blockie_app/app/modules/nft_detail.dart';
import 'package:blockie_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:blockie_app/app/modules/profile/views/profile_view.dart';
import 'package:blockie_app/app/modules/project_details/bindings/project_details_binding.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_view.dart';
import 'package:blockie_app/app/modules/projects_management/bindings/projects_management_binding.dart';
import 'package:blockie_app/app/modules/projects_management/views/projects_management_view.dart';
import 'package:blockie_app/app/modules/registration_info/bindings/registration_info_binding.dart';
import 'package:blockie_app/app/modules/registration_info/views/registration_info_view.dart';
import 'package:blockie_app/app/modules/root/bindings/root_binding.dart';
import 'package:blockie_app/app/modules/root/views/root_view.dart';
import 'package:blockie_app/app/modules/settings/bindings/settings_binding.dart';
import 'package:blockie_app/app/modules/settings/views/settings_view.dart';
import 'package:blockie_app/app/modules/share/bindings/share_binding.dart';
import 'package:blockie_app/app/modules/share/views/share_view.dart';
import 'package:blockie_app/app/modules/subactivities_management/bindings/subactivities_management_binding.dart';
import 'package:blockie_app/app/modules/subactivities_management/views/subactivities_management_view.dart';
import 'package:blockie_app/app/modules/ticket_checking/bindings/ticket_checking_binding.dart';
import 'package:blockie_app/app/modules/ticket_checking/views/ticket_checking_view.dart';
import 'package:blockie_app/app/modules/update_avatar/bindings/update_avatar_binding.dart';
import 'package:blockie_app/app/modules/update_avatar/views/update_avatar_view.dart';
import 'package:blockie_app/app/modules/update_bio/bindings/update_bio_binding.dart';
import 'package:blockie_app/app/modules/update_bio/views/update_bio_view.dart';
import 'package:blockie_app/app/modules/update_username/bindings/update_username_binding.dart';
import 'package:blockie_app/app/modules/update_username/views/update_username_view.dart';
import 'package:blockie_app/app/modules/web_view/bindings/web_view_binding.dart';
import 'package:blockie_app/app/modules/web_view/views/web_view_view.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';
import '../../utils/data_storage.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static final remoteApi = BlockieApi(
    userTokenSupplier: () => DataStorage.getToken(),
  );
  static final _accountRepository = AccountRepository(remoteApi: remoteApi);
  static final _profileRepository = ProfileRepository(remoteApi: remoteApi);
  static final _projectRepository = ProjectRepository(remoteApi: remoteApi);
  static final _projectsManagementRepository =
      ProjectsManagementRepository(remoteApi: remoteApi);

  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => const RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      children: [
        GetPage(
          name: Routes.activities,
          page: () => const ActivitiesContainerView(),
          binding: ActivitiesBinding(
            accountRepository: _accountRepository,
            projectRepository: _projectRepository,
          ),
        ),
        GetPage(
          name: Routes.brand,
          page: () => const BrandDetailsView(),
          binding: BrandDetailsBinding(
            projectRepository: _projectRepository,
          ),
        ),
        GetPage(
          name: Routes.projectDetails,
          page: () => const ProjectDetailsContainerView(),
          binding: ProjectDetailsBinding(
            accountRepository: _accountRepository,
            projectRepository: _projectRepository,
          ),
        ),
        GetPage(
          name: Routes.gallery,
          page: () => const GalleryView(),
          binding: GalleryBinding(),
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
          name: Routes.updateUsername,
          page: () => const UpdateUsernameView(),
          binding: UpdateUsernameBinding(profileRepository: _profileRepository),
        ),
        GetPage(
          name: Routes.updateBio,
          page: () => const UpdateBioView(),
          binding: UpdateBioBinding(profileRepository: _profileRepository),
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
          binding:
              FaceVerificationBinding(accountRepository: _accountRepository),
        ),
        GetPage(
          name: Routes.activity,
          page: () => const ActivityContainerView(),
          binding: ActivityBinding(
            accountRepository: _accountRepository,
            projectRepository: _projectRepository,
          ),
        ),
        GetPage(
          name: Routes.webView,
          page: () => const WebViewView(),
          binding: WebViewBinding(),
        ),
        GetPage(
          name: Routes.activitiesManagement,
          page: () => const ActivitiesManagementContainerView(),
          binding: ActivitiesManagementBinding(
              projectsManagementRepository: _projectsManagementRepository),
        ),
        GetPage(
          name: Routes.subactivitiesManagement,
          page: () => const SubactivitiesManagementView(),
          binding: SubactivitiesManagementBinding(),
        ),
        GetPage(
          name: Routes.projectsManagement,
          page: () => const ProjectsManagementView(),
          binding: ProjectsManagementBinding(
              projectsManagementRepository: _projectsManagementRepository),
        ),
        GetPage(
          name: Routes.ticketChecking,
          page: () => const TicketCheckingContainerView(),
          binding: TicketCheckingBinding(
              projectsManagementRepository: _projectsManagementRepository),
        ),
        GetPage(
          name: Routes.addWhitelist,
          page: () => const AddWhitelistContainerView(),
          binding: AddWhitelistBinding(
              projectsManagementRepository: _projectsManagementRepository),
        ),
        GetPage(
          name: Routes.airdropNft,
          page: () => const AirdropNftContainerView(),
          binding: AirdropNftBinding(
              projectsManagementRepository: _projectsManagementRepository),
        ),
        GetPage(
          name: Routes.holdVerification,
          page: () => const HoldVerificationContainerView(),
          binding: HoldVerificationBinding(
              projectsManagementRepository: _projectsManagementRepository),
        ),
        GetPage(
          name: Routes.profile,
          page: () => const ProfileContainerView(),
          binding: ProfileBinding(
            accountRepository: _accountRepository,
            profileRepository: _profileRepository,
          ),
        ),
        GetPage(
          name: Routes.share,
          page: () => const ShareView(),
          binding: ShareBinding(projectRepository: _projectRepository),
        ),
        GetPage(
          name: Routes.developerMode,
          page: () => const DeveloperModeView(),
          binding: DeveloperModeBinding(),
        ),
      ],
    ),
  ];
}
