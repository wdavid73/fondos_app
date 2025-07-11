import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/domain/datasources/fund_datasource.dart';
import 'package:flutter_starter_kit/domain/repositories/fund_repository.dart';

class FundRepositoryImpl implements FundRepository {
  final FundDataSource _dataSource;

  FundRepositoryImpl(this._dataSource);

  @override
  Future<bool> cancelSubscriptionToFund() async {
    return _dataSource.cancelSubscriptionToFund();
  }

  @override
  Future<List<FundModel>> loadFunds() async {
    return _dataSource.loadFunds();
  }

  @override
  Future<bool> subscribeToFund() async {
    return _dataSource.subscribeToFund();
  }
}
