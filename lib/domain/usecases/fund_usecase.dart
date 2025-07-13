import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/domain/repositories/repositories.dart';

/// A use case class for handling fund-related operations.
///
/// This class provides methods for loading funds, subscribing, and cancelling subscriptions.
/// It interacts with a [FundRepository] to perform these operations.
class FundUsecase {
  /// The [FundRepository] used to perform fund operations.
  final FundRepository _repository;

  /// Creates a [FundUsecase] instance.
  FundUsecase(this._repository);

  /// Loads the list of available funds.
  Future<List<FundModel>> loadFunds() {
    return _repository.loadFunds();
  }

  /// Subscribes to a fund.
  Future<bool> subscribeToFund() {
    return _repository.subscribeToFund();
  }

  /// Cancels the subscription to a fund.
  Future<bool> cancelSubscriptionToFund() {
    return _repository.cancelSubscriptionToFund();
  }
}
