import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_starter_kit/data/models/fund_model.dart';
import 'package:flutter_starter_kit/domain/datasources/fund_datasource.dart';

class MockFundDataSource implements FundDataSource {
  @override
  Future<List<FundModel>> loadFunds() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/mocks/funds_mocks.json',
      );
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => FundModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Error loading funds");
    }
  }

  @override
  Future<bool> subscribeToFund() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> cancelSubscriptionToFund() async {
    throw UnimplementedError();
  }
}
