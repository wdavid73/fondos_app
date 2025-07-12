import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/domain/repositories/repositories.dart';

class FundUsecase {
  final FundRepository _repository;

  FundUsecase(this._repository);

  Future<List<FundModel>> loadFunds() {
    return _repository.loadFunds();
  }

  Future<bool> subscribeToFund() {
    return _repository.subscribeToFund();
  }

  Future<bool> cancelSubscriptionToFund() {
    return _repository.cancelSubscriptionToFund();
  }
}
