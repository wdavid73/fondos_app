import 'package:fondos_app/data/models/fund_model.dart';

/// A utility class for mapping between JSON data and [FundModel] objects.
///
/// Provides static methods to convert a JSON map into a [FundModel] and to convert a [FundModel] into a JSON map.
class FundMapper {
  /// Converts a JSON map into a [FundModel].
  ///
  /// Parameters:
  ///   - [json]: The JSON map to convert.
  ///
  /// Returns:
  ///   - A [FundModel] instance created from the JSON data.
  static FundModel fundJsonToModel(Map<String, dynamic> json) => FundModel(
        id: json["id"].toString(),
        name: json["name"],
        amountMin: json["min_amount"],
        category: json["category"],
      );

  /// Converts a [FundModel] into a JSON map.
  ///
  /// Parameters:
  ///   - [fund]: The [FundModel] to convert.
  ///
  /// Returns:
  ///   - A JSON map representing the [FundModel].
  static Map<String, dynamic> toJson(FundModel fund) => {
        'id': fund.id,
        'name': fund.name,
        'amount_min': fund.amountMin,
        'category': fund.category,
      };
}
