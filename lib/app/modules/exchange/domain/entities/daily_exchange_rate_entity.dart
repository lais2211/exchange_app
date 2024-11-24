class DailyExchangeRateEntity {
  String date;
  double open;
  double high;
  double low;
  double close;

  DailyExchangeRateEntity(
      {required this.date,
      required this.open,
      required this.high,
      required this.low,
      required this.close});
}
