import 'package:flutter_demo_getx/pages/home-qr/controllers/home_qr_controller.dart';
import 'package:flutter_demo_getx/services/repository/infrastructure/proposal/proposal_repository.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/proposal/i_proposal_repository.dart';
import 'package:get/get.dart';

class HomeQrBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut<IHomeProvider>(() => HomeProvider());
    Get.lazyPut<IProposalRepository>(
        () => ProposalRepository(apiProvider: Get.find()));
    Get.lazyPut(() => HomeQrController(proposalRepository: Get.find()));
  }
}
