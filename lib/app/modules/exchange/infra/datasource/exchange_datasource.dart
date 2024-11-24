import 'package:exchange_app/app/modules/exchange/infra/models/current_exchange_model.dart';
import 'package:exchange_app/app/modules/exchange/infra/models/daily_exchange_model.dart';

abstract class ExchangeDatasource {
  Future<CurrentExchangeModel> getCurrentExchange(
      {required String fromSymbol,
      required String toSymbol,
      required String apiKey});

  Future<DailyExchangeModel> getDailyExchange(
      {required String fromSymbol,
      required String toSymbol,
      required String apiKey});
}
