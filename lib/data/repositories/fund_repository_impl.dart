import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/domain/datasources/fund_datasource.dart';
import 'package:fondos_app/domain/repositories/fund_repository.dart';

/// Implementation of [FundRepository] that interacts with a fund data source.
///
/// This class acts as an intermediary between the domain layer and the data layer,
/// delegating fund-related operations to a [FundDataSource] instance.
class FundRepositoryImpl implements FundRepository {
  /// The data source responsible for handling fund requests.
  final FundDataSource _dataSource;

  /// Creates an instance of [FundRepositoryImpl] with the provided [_dataSource].
  FundRepositoryImpl(this._dataSource);

  @override

  /// Cancels the subscription to a fund.
  Future<bool> cancelSubscriptionToFund() async {
    return _dataSource.cancelSubscriptionToFund();
  }

  @override

  /// Loads the list of available funds.
  Future<List<FundModel>> loadFunds() async {
    return _dataSource.loadFunds();
  }

  @override

  /// Subscribes to a fund.
  Future<bool> subscribeToFund() async {
    return _dataSource.subscribeToFund();
  }
}
