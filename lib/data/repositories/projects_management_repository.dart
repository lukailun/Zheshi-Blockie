// Project imports:
import 'package:blockie_app/app/modules/activities/models/paginated_activities.dart';
import 'package:blockie_app/app/modules/add_whitelist/models/add_whitelist_details.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/ticket_checking_details.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';

class ProjectsManagementRepository {
  final BlockieApi remoteApi;

  ProjectsManagementRepository({
    required this.remoteApi,
  });

  Future<PaginatedActivities?> getManagedActivities() =>
      remoteApi.getManagedActivities();

  Future<TicketCheckingDetails?> getManagedProjectNfts({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.getManagedProjectNfts(id: id, qrCode: qrCode);

  Future<AddWhitelistDetails?> getWhitelistStatus({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.getWhitelistStatus(id: id, qrCode: qrCode);

  Future<TicketCheckingDetails?> checkTickets({
    required List<Map<String, String>> souvenirsMapList,
    required String qrCode,
  }) =>
      remoteApi.checkTickets(
          souvenirsMapList: souvenirsMapList, qrCode: qrCode);
}
