// Project imports:
import 'package:blockie_app/app/modules/activities/models/paginated_activities.dart';
import 'package:blockie_app/app/modules/activity/models/activity.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';
import 'package:blockie_app/app/modules/registration_info/models/registration_info.dart';
import 'package:blockie_app/app/modules/share/models/share_info.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';
import '../../models/nft_info.dart';

class ProjectRepository {
  final BlockieApi remoteApi;

  ProjectRepository({
    required this.remoteApi,
  });

  Future<PaginatedActivities?> getActivities() => remoteApi.getActivities();

  Future<Activity?> getActivity(String id) => remoteApi.getActivity(id);

  Future<RegistrationInfo?> getRegistrationInfo(String id) =>
      remoteApi.getRegistrationInfo(id);

  Future<bool> updateRegistrationInfo(
          String id, String number, bool isUpdate) =>
      remoteApi.updateRegistrationInfo(id, number, isUpdate);

  Future<ShareInfo?> getProjectDetailsShareInfo(String id) =>
      remoteApi.getProjectDetailsShareInfo(id);

  Future<ShareInfo?> getNFTDetailsShareInfo(String id) =>
      remoteApi.getNftDetailsShareInfo(id);

  Future<ProjectDetails?> getProjectDetails(String id) =>
      remoteApi.getProjectDetails(id);

  Future<NftInfo?> mint(String id) => remoteApi.mint(id);
}
