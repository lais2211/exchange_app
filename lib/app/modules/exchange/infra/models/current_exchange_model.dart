import '../../domain/entities/current_exchange_entity.dart';

class CurrentExchangeModel extends CurrentExchangeEntity {
  CurrentExchangeModel(
      {required super.fromSymbol,
      required super.toSymbol,
      required super.lastUpdatedAt,
      required super.exchangeRate});

  factory CurrentExchangeModel.fromMap(Map<String, dynamic> map) {
    return CurrentExchangeModel(
        fromSymbol: map['fromSymbol'],
        toSymbol: map['toSymbol'],
        lastUpdatedAt: map['lastUpdatedAt'],
        exchangeRate: map['exchangeRate']);
  }

  Map<String, dynamic> toMap() {
    return {
      'fromSymbol': fromSymbol,
      'toSymbol': toSymbol,
      'lastUpdatedAt': lastUpdatedAt,
      'exchangeRate': exchangeRate
    };
  }
}
