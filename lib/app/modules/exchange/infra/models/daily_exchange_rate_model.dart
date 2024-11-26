import '../../domain/entities/daily_exchange_rate_entity.dart';

class DailyExchangeRateModel extends DailyExchangeRateEntity {
  DailyExchangeRateModel({
    required super.open,
    required super.high,
    required super.low,
    required super.close,
    required super.date,
  });

  factory DailyExchangeRateModel.fromMap(Map<String, dynamic> map) {
    return DailyExchangeRateModel(
        open: map['open'],
        high: map['high'],
        low: map['low'],
        close: map['close'],
        date: map['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'date': date
    };
  }

  static List<DailyExchangeRateModel> listFromMap(List<dynamic> data) {
    return data
        .map((rate) =>
            DailyExchangeRateModel.fromMap(rate as Map<String, dynamic>))
        .toList();
  }

  static List<Map<String, dynamic>> listToMap(
      List<DailyExchangeRateModel> rates) {
    return rates.map((rate) => rate.toMap()).toList();
  }
}
