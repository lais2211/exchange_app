import 'daily_exchange_rate_entity.dart';

class DailyExchangeEntity {
  String from;
  String to;
  String lastUpdatedAt;
  List<DailyExchangeRateEntity> dailyExchangeRateEntity;

  DailyExchangeEntity({
    required this.from,
    required this.to,
    required this.lastUpdatedAt,
    required this.dailyExchangeRateEntity
  });
}