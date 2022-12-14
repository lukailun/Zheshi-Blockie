part of 'projects_management_controller.dart';

extension ProjectsManagementControllerRouter on ProjectsManagementController {
  void openProjectOperationDialog(Project project) {
    Get.projectsManagementDialog(
      project: project,
      ticketCheckingOnTap: () => goToTicketChecking(project),
      addWhitelistOnTap: () => goToAddWhitelist(project),
      airdropNftOnTap: () => goToAirdropNft(project),
      holdVerificationOnTap: () => goToHoldVerification(project),
    );
  }

  void goToTicketChecking(Project project) {
    final parameters = {TicketCheckingParameter.id: project.id};
    AppRouter.toNamed(Routes.ticketChecking, parameters: parameters);
  }

  void goToAddWhitelist(Project project) {
    final parameters = {AddWhitelistParameter.id: project.id};
    AppRouter.toNamed(Routes.addWhitelist, parameters: parameters);
  }

  void goToAirdropNft(Project project) {
    final parameters = {AirdropNftParameter.id: project.id};
    AppRouter.toNamed(Routes.airdropNft, parameters: parameters);
  }

  void goToHoldVerification(Project project) {
    final parameters = {HoldVerificationParameter.id: project.id};
    AppRouter.toNamed(Routes.holdVerification, parameters: parameters);
  }
}
