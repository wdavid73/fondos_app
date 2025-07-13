import 'package:fondos_app/data/models/fund_model.dart';

/// Defines the contract for fund data source operations.
///
/// Implementations of this class are responsible for providing fund data, subscription, and cancellation logic.
abstract class FundDataSource {
  /// Loads the list of available funds.
  Future<List<FundModel>> loadFunds();

  /// Subscribes to a fund.
  Future<bool> subscribeToFund();

  /// Cancels the subscription to a fund.
  Future<bool> cancelSubscriptionToFund();
}
