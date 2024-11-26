class CurrentExchangeEntity {
  String fromSymbol;
  String toSymbol;
  String lastUpdatedAt;
  double exchangeRate;

  CurrentExchangeEntity({
    required this.fromSymbol,
    required this.toSymbol,
    required this.lastUpdatedAt,
    required this.exchangeRate
  });
}