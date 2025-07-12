import 'package:fondos_app/data/mappers/fund_mapper.dart';
import 'package:fondos_app/data/models/json_serializable.dart';
import 'package:fondos_app/domain/entities/fund_entity.dart';

class FundModel extends FundEntity implements JsonSerializable {
  FundModel({
    required super.id,
    required super.name,
    required super.amountMin,
    required super.category,
  });

  factory FundModel.fromJson(Map<String, dynamic> json) {
    return FundMapper.fundJsonToModel(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return FundMapper.toJson(this);
  }
}
