import 'package:fondos_app/data/models/fund_model.dart';

/// Defines the contract for fund-related operations.
///
/// Implementations of this class are responsible for handling fund loading, subscription, and cancellation.
abstract class FundRepository {
  /// Loads the list of available funds.
  Future<List<FundModel>> loadFunds();

  /// Subscribes to a fund.
  Future<bool> subscribeToFund();

  /// Cancels the subscription to a fund.
  Future<bool> cancelSubscriptionToFund();
}
