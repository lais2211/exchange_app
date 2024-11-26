import 'package:dartz/dartz.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/current_exchange_entity.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/daily_exchange_entity.dart';
import '../../../../core/errors/errors.dart';

abstract class ExchangeRepository {
  Future<Either<FailureSearch, CurrentExchangeEntity>> current({
    required String fromSymbol,
  });

  Future<Either<FailureSearch, DailyExchangeEntity>> daily({
    required String fromSymbol,
  });
}
