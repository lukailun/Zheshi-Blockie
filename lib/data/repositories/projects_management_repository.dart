// Project imports:
import 'package:blockie_app/app/modules/activities_management/models/paginated_managed_activities.dart';
import 'package:blockie_app/app/modules/add_whitelist/models/add_whitelist_details.dart';
import 'package:blockie_app/app/modules/airdrop_nft/models/airdrop_nft_details.dart';
import 'package:blockie_app/app/modules/hold_verification/models/hold_verification_details.dart';
import 'package:blockie_app/app/modules/ticket_checking/models/ticket_checking_details.dart';
import 'package:blockie_app/data/apis/blockie_api/blockie_api.dart';

class ProjectsManagementRepository {
  final BlockieApi remoteApi;

  ProjectsManagementRepository({
    required this.remoteApi,
  });

  Future<PaginatedManagedActivities?> getManagedActivities() =>
      remoteApi.getManagedActivities();

  Future<TicketCheckingDetails?> getTicketCheckingDetails({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.getTicketCheckingDetails(id: id, qrCode: qrCode);

  Future<HoldVerificationDetails?> getHoldVerificationDetails({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.getHoldVerificationDetails(id: id, qrCode: qrCode);

  Future<AirdropNftDetails?> getAirdropNfts({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.getAirdropNfts(id: id, qrCode: qrCode);

  Future<AirdropNftDetails?> airdropNfts({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.airdropNfts(id: id, qrCode: qrCode);

  Future<AddWhitelistDetails?> getWhitelistStatus({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.getWhitelistStatus(id: id, qrCode: qrCode);

  Future<AddWhitelistDetails?> addWhitelist({
    required String id,
    required String qrCode,
  }) =>
      remoteApi.addWhitelist(id: id, qrCode: qrCode);

  Future<TicketCheckingDetails?> checkTickets({
    required List<Map<String, String>> souvenirsMapList,
    required String qrCode,
  }) =>
      remoteApi.checkTickets(
          souvenirsMapList: souvenirsMapList, qrCode: qrCode);
}
