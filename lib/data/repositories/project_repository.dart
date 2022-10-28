// Project imports:
import 'package:blockie_app/app/modules/activity/models/activity.dart';
import 'package:blockie_app/app/modules/project_details/models/project_details.dart';
import 'package:blockie_app/app/modules/projects_management/models/paginated_projects.dart';
import 'package:blockie_app/app/modules/registration_info/models/registration_info.dart';
import 'package:blockie_app/app/modules/share/models/share_info.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/ticket_checking_details.dart';
import 'package:blockie_app/data/apis/blockie_api.dart';
import 'package:blockie_app/utils/http_request.dart';
import '../../models/nft_info.dart';

class ProjectRepository {
  final HttpRequest client;
  final BlockieApi remoteApi;

  ProjectRepository({required this.client, required this.remoteApi});

  Future<PaginatedProjects?> getProjects() => remoteApi.getProjects();

  Future<PaginatedProjects?> getManagedProjects() =>
      remoteApi.getManagedProjects();

  Future<TicketCheckingDetails?> getManagedProjectNfts({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.getManagedProjectNfts(id: id, qrCode: qrCode);

  Future<TicketCheckingDetails?> checkTickets({
    required List<Map<String, String>> souvenirsMapList,
    required String qrCode,
  }) =>
      remoteApi.checkTickets(
          souvenirsMapList: souvenirsMapList, qrCode: qrCode);

  Future<Activity> getActivity(String id) => client.getActivity(id);

  Future<RegistrationInfo> getRegistrationInfo(String id) =>
      client.getRegistrationInfo(id);

  Future<bool> updateRegistrationInfo(
          String id, String number, bool isUpdate) =>
      client.updateRegistrationInfo(id, number, isUpdate);

  Future<ShareInfo> getProjectDetailsShareInfo(String id) =>
      client.getProjectDetailsShareInfo(id);

  Future<ShareInfo> getNFTDetailsShareInfo(String id) =>
      client.getNFTDetailsShareInfo(id);

  Future<ProjectDetails?> getProjectDetails(String id) =>
      remoteApi.getProjectDetails(id);

  Future<NftInfo?> mint(String id) => remoteApi.mint(id);
}
