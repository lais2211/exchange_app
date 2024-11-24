import 'package:dartz/dartz.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/current_exchange_entity.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/daily_exchange_entity.dart';
import 'package:exchange_app/app/modules/exchange/domain/repositories/exchange_repository.dart';
import 'package:exchange_app/app/modules/exchange/infra/datasource/exchange_datasource.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/errors.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeDatasource datasource;
  Logger logger;

  ExchangeRepositoryImpl({required this.datasource, required this.logger});

  @override
  Future<Either<FailureSearch, DailyExchangeEntity>> daily(
      {required String apiKey,
      required String from_symbol,
      required String to_symbol}) async {
    logger.d('Inicio do repository na infra daily.');
    try {
      final result = await datasource.getDailyExchange(
          fromSymbol: from_symbol, toSymbol: to_symbol, apiKey: apiKey);
      logger.d(
        result.toString(),
      );
      return Right(result as DailyExchangeEntity);
    } on Exception {
      return Left(DataSourceFailure());
    }
  }

  @override
  Future<Either<FailureSearch, CurrentExchangeEntity>> current(
      {required String apiKey,
      required String from_symbol,
      required String to_symbol}) async {
    logger.d('Inicio do repository na infra current.');
    try {
      final result = await datasource.getCurrentExchange(
          fromSymbol: from_symbol, toSymbol: to_symbol, apiKey: apiKey);
      logger.d(
        result,
      );
      return Right(result);
    } on Exception {
      return Left(DataSourceFailure());
    }
  }
}
