import 'package:fondos_app/data/models/fund_model.dart';

abstract class FundRepository {
  Future<List<FundModel>> loadFunds();
  Future<bool> subscribeToFund();
  Future<bool> cancelSubscriptionToFund();
}
