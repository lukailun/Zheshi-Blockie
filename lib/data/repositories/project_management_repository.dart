// Project imports:
import 'package:blockie_app/app/modules/projects_management/models/paginated_projects.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/ticket_checking_details.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';

class ProjectManagementRepository {
  final BlockieApi remoteApi;

  ProjectManagementRepository({
    required this.remoteApi,
  });

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
}
