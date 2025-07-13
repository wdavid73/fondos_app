import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fondos_app/data/models/fund_model.dart';
import 'package:fondos_app/domain/datasources/fund_datasource.dart';

/// Implementación de [FundDataSource] que utiliza datos mockeados desde un archivo local.
///
/// Esta clase simula la obtención y suscripción a fondos para propósitos de desarrollo y pruebas.
class MockFundDataSource implements FundDataSource {
  /// Carga la lista de fondos desde un archivo JSON local.
  ///
  /// Retorna una lista de [FundModel] obtenida del archivo 'assets/mocks/funds_mocks.json'.
  /// Lanza una excepción si ocurre un error durante la carga o el parseo.
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

  /// Simula la suscripción a un fondo.
  ///
  /// Actualmente no implementado. Lanza [UnimplementedError].
  @override
  Future<bool> subscribeToFund() async {
    throw UnimplementedError();
  }

  /// Simula la cancelación de la suscripción a un fondo.
  ///
  /// Actualmente no implementado. Lanza [UnimplementedError].
  @override
  Future<bool> cancelSubscriptionToFund() async {
    throw UnimplementedError();
  }
}
