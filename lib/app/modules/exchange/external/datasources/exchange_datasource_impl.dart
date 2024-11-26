import 'package:dio/dio.dart';
import 'package:exchange_app/app/modules/exchange/infra/models/current_exchange_model.dart';
import 'package:exchange_app/app/modules/exchange/infra/models/daily_exchange_model.dart';
import 'package:logger/logger.dart';

import '../../../../core/config/config_env.dart';
import '../../../../core/errors/errors.dart';
import '../../infra/datasource/exchange_datasource.dart';
import '../../l10n/exchange_l10n.dart';

class ExchangeDatasourceImpl implements ExchangeDatasource {
  Dio dio;
  Logger logger;
  final ExchangeL10n text = ExchangeL10n();

  ExchangeDatasourceImpl({required this.dio, required this.logger});

  String statusCodeToMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return text.sucess;
      case 404:
        return text.notFound;
      case 500:
        return text.serverError;
      default:
        return text.unknownError;
    }
  }

  @override
  Future<CurrentExchangeModel> getCurrentExchange({
    required String fromSymbol,
  }) async {
    try {
      final response = await dio.get(
        ConfigEnv.currentPath,
        queryParameters: {
          'from_symbol': fromSymbol,
        },
      );

      final statusCode = response.statusCode!;

      if (statusCode == 200) {
        logger.d('A requisição do getCurrentExchange retornou 200.');
        logger.d('O fromSymbol é : $fromSymbol');

        return CurrentExchangeModel.fromMap(response.data);
      }
      throw DataSourceFailure(
          errorCode: statusCode, errorMessage: statusCodeToMessage(statusCode));
    } catch (e) {
      throw InternalServerError(text.error);
    }
  }

  @override
  Future<DailyExchangeModel> getDailyExchange({
    required String fromSymbol,
  }) async {
    try {
      final response = await dio.get(
        ConfigEnv.dailyPath,
        queryParameters: {
          'from_symbol': fromSymbol,
        },
      );

      final statusCode = response.statusCode!;

      if (statusCode == 200) {
        logger.d('A requisição do getDailyExchange retornou 200.');
        logger.d('O fromSymbol é : $fromSymbol');

        return DailyExchangeModel.fromMap(response.data);
      }
      throw DataSourceFailure(
          errorCode: statusCode, errorMessage: statusCodeToMessage(statusCode));
    } catch (e) {
      throw InternalServerError(text.error);
    }
  }
}
