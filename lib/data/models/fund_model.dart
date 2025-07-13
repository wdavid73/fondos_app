import 'package:fondos_app/data/mappers/fund_mapper.dart';
import 'package:fondos_app/data/models/json_serializable.dart';
import 'package:fondos_app/domain/entities/fund_entity.dart';

/// A model representing an investment fund.
///
/// Extends [FundEntity] and implements [JsonSerializable] for JSON conversion.
/// Provides factory and serialization methods using [FundMapper].
class FundModel extends FundEntity implements JsonSerializable {
  /// Creates a [FundModel] instance.
  ///
  /// Parameters:
  ///   - [id]: The unique identifier of the fund.
  ///   - [name]: The name of the fund.
  ///   - [amountMin]: The minimum amount required to invest.
  ///   - [category]: The category of the fund.
  FundModel({
    required super.id,
    required super.name,
    required super.amountMin,
    required super.category,
  });

  /// Creates a [FundModel] instance from a JSON map.
  ///
  /// Uses [FundMapper] to convert a JSON map into a [FundModel] object.
  ///
  /// Parameters:
  ///   - [json]: The JSON map to convert.
  ///
  /// Returns:
  ///   - A [FundModel] instance created from the JSON data.
  factory FundModel.fromJson(Map<String, dynamic> json) {
    return FundMapper.fundJsonToModel(json);
  }

  /// Converts the [FundModel] to a JSON map.
  ///
  /// Uses [FundMapper] to convert the [FundModel] object into a JSON map.
  ///
  /// Returns:
  ///   - A JSON map representing the [FundModel].
  @override
  Map<String, dynamic> toJson() {
    return FundMapper.toJson(this);
  }
}
