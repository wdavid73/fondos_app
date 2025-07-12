import 'package:fondos_app/domain/entities/base_entity.dart';

class FundEntity extends BaseEntity {
  @override
  final String id;

  final String name;

  final String amountMin;
  final String category;

  FundEntity({
    required this.id,
    required this.name,
    required this.amountMin,
    required this.category,
  }) : super();
}
