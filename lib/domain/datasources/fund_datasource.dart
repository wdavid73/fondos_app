import 'package:fondos_app/data/models/fund_model.dart';

abstract class FundDataSource {
  Future<List<FundModel>> loadFunds();
  Future<bool> subscribeToFund();
  Future<bool> cancelSubscriptionToFund();
}
