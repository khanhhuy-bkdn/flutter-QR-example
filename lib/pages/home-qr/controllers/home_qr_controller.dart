import 'package:flutter_demo_getx/services/repository/interfaces/proposal/i_proposal_repository.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeQrController extends GetxController {
  HomeQrController({required this.proposalRepository});
  final IProposalRepository proposalRepository;

  bool isLoadingProposal = false;
  bool isLoadingApproveList = false;
  bool isLoadingInventoryDetail = false;
}
