import '../../domain/entities/daily_exchange_entity.dart';
import 'daily_exchange_rate_model.dart';

class DailyExchangeModel extends DailyExchangeEntity {
  DailyExchangeModel({
    required super.from,
    required super.to,
    required super.lastUpdatedAt,
    required super.dailyExchangeRateEntity,
  });

  factory DailyExchangeModel.fromMap(Map<String, dynamic> map) {
    return DailyExchangeModel(
        from: map['from'],
        to: map['to'],
        lastUpdatedAt: map['lastUpdatedAt'],
        dailyExchangeRateEntity:
            DailyExchangeRateModel.listFromMap(map['data']));
  }

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
      'lastUpdatedAt': lastUpdatedAt,
      'data': DailyExchangeRateModel.listToMap(
          dailyExchangeRateEntity.cast<DailyExchangeRateModel>()),
    };
  }
}
