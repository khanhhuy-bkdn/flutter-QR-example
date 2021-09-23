import 'package:flutter_demo_getx/services/provider/i_api_provider.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/proposal/i_proposal_repository.dart';

class ProposalRepository implements IProposalRepository {
  ProposalRepository({required this.apiProvider});
  final IApiProvider apiProvider;

  // @override

}
