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
import 'package:blockie_app/app/modules/edit_user_info/bindings/edit_user_info_binding.dart';
import 'package:blockie_app/app/modules/edit_user_info/views/edit_user_info_view.dart';
import 'package:blockie_app/app/modules/face_verification/bindings/face_verification_binding.dart';
import 'package:blockie_app/app/modules/face_verification/views/face_verification_view.dart';
import 'package:blockie_app/app/modules/gallery/bindings/gallery_binding.dart';
import 'package:blockie_app/app/modules/gallery/views/gallery_view.dart';
import 'package:blockie_app/app/modules/hold_verification/bindings/hold_verification_binding.dart';
import 'package:blockie_app/app/modules/hold_verification/views/hold_verification_view.dart';
import 'package:blockie_app/app/modules/nft_details/bindings/nft_details_binding.dart';
import 'package:blockie_app/app/modules/nft_details/views/nft_details_view.dart';
import 'package:blockie_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:blockie_app/app/modules/profile/views/profile_view.dart';
import 'package:blockie_app/app/modules/project_details/bindings/project_details_binding.dart';
import 'package:blockie_app/app/modules/project_details/views/project_details_view.dart';
import 'package:blockie_app/app/modules/projects_management/bindings/projects_management_binding.dart';
import 'package:blockie_app/app/modules/projects_management/views/projects_management_view.dart';
import 'package:blockie_app/app/modules/registration_info/bindings/registration_info_binding.dart';
import 'package:blockie_app/app/modules/registration_info/views/registration_info_view.dart';
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
import 'package:blockie_app/app/modules/update_birthday/bindings/update_birthday_binding.dart';
import 'package:blockie_app/app/modules/update_birthday/views/update_birthday_view.dart';
import 'package:blockie_app/app/modules/update_gender/bindings/update_gender_binding.dart';
import 'package:blockie_app/app/modules/update_gender/views/update_gender_view.dart';
import 'package:blockie_app/app/modules/update_region/bindings/update_region_binding.dart';
import 'package:blockie_app/app/modules/update_region/views/update_region_view.dart';
import 'package:blockie_app/app/modules/update_username/bindings/update_username_binding.dart';
import 'package:blockie_app/app/modules/update_username/views/update_username_view.dart';
import 'package:blockie_app/app/modules/web_view/bindings/web_view_binding.dart';
import 'package:blockie_app/app/modules/web_view/views/web_view_view.dart';
import 'package:blockie_app/data/repositories/account_repository.dart';
import 'package:blockie_app/data/repositories/common_repository.dart';
import 'package:blockie_app/data/repositories/profile_repository.dart';
import 'package:blockie_app/data/repositories/project_repository.dart';
import 'package:blockie_app/data/repositories/projects_management_repository.dart';

part 'app_routes.dart';

class AppPages {
  final AccountRepository accountRepository;
  final CommonRepository commonRepository;
  final ProfileRepository profileRepository;
  final ProjectRepository projectRepository;
  final ProjectsManagementRepository projectsManagementRepository;

  AppPages({
    required this.accountRepository,
    required this.commonRepository,
    required this.profileRepository,
    required this.projectRepository,
    required this.projectsManagementRepository,
  });

  List<GetPage> get routes => [
        GetPage(
          name: Routes.activities,
          page: () => const ActivitiesContainerView(),
          binding: ActivitiesBinding(
            accountRepository: accountRepository,
            projectRepository: projectRepository,
          ),
        ),
        GetPage(
          name: Routes.brand,
          page: () => const BrandDetailsView(),
          binding: BrandDetailsBinding(
            projectRepository: projectRepository,
          ),
        ),
        GetPage(
          name: Routes.projectDetails,
          page: () => const ProjectDetailsContainerView(),
          binding: ProjectDetailsBinding(
            accountRepository: accountRepository,
            projectRepository: projectRepository,
          ),
        ),
        GetPage(
          name: Routes.gallery,
          page: () => const GalleryView(),
          binding: GalleryBinding(),
        ),
        GetPage(
          name: Routes.nftDetails,
          page: () => const NftDetailsView(),
          binding: NftDetailsBinding(projectRepository: projectRepository),
        ),
        GetPage(
          name: Routes.settings,
          page: () => const SettingsView(),
          binding: SettingsBinding(accountRepository: accountRepository),
        ),
        GetPage(
          name: Routes.updateUsername,
          page: () => const UpdateUsernameView(),
          binding: UpdateUsernameBinding(accountRepository: accountRepository),
        ),
        GetPage(
          name: Routes.updateBio,
          page: () => const UpdateBioView(),
          binding: UpdateBioBinding(accountRepository: accountRepository),
        ),
        GetPage(
          name: Routes.updateAvatar,
          page: () => const UpdateAvatarView(),
          binding: UpdateAvatarBinding(accountRepository: accountRepository),
        ),
        GetPage(
          name: Routes.updateGender,
          page: () => const UpdateGenderView(),
          binding: UpdateGenderBinding(accountRepository: accountRepository),
        ),
        GetPage(
          name: Routes.updateBirthday,
          page: () => const UpdateBirthdayView(),
          binding: UpdateBirthdayBinding(accountRepository: accountRepository),
        ),
        GetPage(
          name: Routes.updateRegion,
          page: () => const UpdateRegionView(),
          binding: UpdateRegionBinding(
            accountRepository: accountRepository,
            commonRepository: commonRepository,
          ),
        ),
        GetPage(
          name: Routes.registrationInfo,
          page: () => const RegistrationInfoView(),
          binding: RegistrationInfoBinding(
            accountRepository: accountRepository,
            projectRepository: projectRepository,
          ),
        ),
        GetPage(
          name: Routes.faceVerification,
          page: () => FaceVerificationView(),
          binding:
              FaceVerificationBinding(accountRepository: accountRepository),
        ),
        GetPage(
          name: Routes.activity,
          page: () => const ActivityContainerView(),
          binding: ActivityBinding(
            accountRepository: accountRepository,
            projectRepository: projectRepository,
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
              projectsManagementRepository: projectsManagementRepository),
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
              projectsManagementRepository: projectsManagementRepository),
        ),
        GetPage(
          name: Routes.ticketChecking,
          page: () => const TicketCheckingContainerView(),
          binding: TicketCheckingBinding(
              projectsManagementRepository: projectsManagementRepository),
        ),
        GetPage(
          name: Routes.addWhitelist,
          page: () => const AddWhitelistContainerView(),
          binding: AddWhitelistBinding(
              projectsManagementRepository: projectsManagementRepository),
        ),
        GetPage(
          name: Routes.airdropNft,
          page: () => const AirdropNftContainerView(),
          binding: AirdropNftBinding(
              projectsManagementRepository: projectsManagementRepository),
        ),
        GetPage(
          name: Routes.holdVerification,
          page: () => const HoldVerificationContainerView(),
          binding: HoldVerificationBinding(
              projectsManagementRepository: projectsManagementRepository),
        ),
        GetPage(
          name: Routes.profile,
          page: () => const ProfileView(),
          binding: ProfileBinding(
            accountRepository: accountRepository,
            profileRepository: profileRepository,
          ),
        ),
        GetPage(
          name: Routes.editUserInfo,
          page: () => const EditUserInfoView(),
          binding: EditUserInfoBinding(accountRepository: accountRepository),
        ),
        GetPage(
          name: Routes.share,
          page: () => const ShareView(),
          binding: ShareBinding(
            projectRepository: projectRepository,
            commonRepository: commonRepository,
          ),
        ),
        GetPage(
          name: Routes.developerMode,
          page: () => const DeveloperModeView(),
          binding: DeveloperModeBinding(),
        ),
      ];
}
