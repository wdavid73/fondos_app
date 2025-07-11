import 'package:flutter_starter_kit/data/models/fund_model.dart';

class FundMapper {
  static FundModel fundJsonToModel(Map<String, dynamic> json) => FundModel(
        id: json["id"].toString(),
        name: json["name"],
        amountMin: json["min_amount"],
        category: json["category"],
      );

  static Map<String, dynamic> toJson(FundModel fund) => {
        'id': fund.id,
        'name': fund.name,
        'amount_min': fund.amountMin,
        'category': fund.category,
      };
}
