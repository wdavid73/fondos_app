import 'package:fondos_app/domain/entities/base_entity.dart';

/// Represents a fund entity in the application.
///
/// Extends [BaseEntity] and includes properties such as name, minimum amount, and category.
class FundEntity extends BaseEntity {
  @override
  final String id;

  /// The name of the fund.
  final String name;

  /// The minimum amount required to invest in the fund.
  final String amountMin;

  /// The category of the fund.
  final String category;

  /// Creates a [FundEntity] instance.
  ///
  /// Parameters:
  ///   - [id]: The unique identifier of the fund.
  ///   - [name]: The name of the fund.
  ///   - [amountMin]: The minimum amount required to invest.
  ///   - [category]: The category of the fund.
  FundEntity({
    required this.id,
    required this.name,
    required this.amountMin,
    required this.category,
  }) : super();
}
