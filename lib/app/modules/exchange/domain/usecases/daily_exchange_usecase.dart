import 'package:dartz/dartz.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/daily_exchange_entity.dart';
import 'package:exchange_app/app/modules/exchange/domain/repositories/exchange_repository.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/errors.dart';

abstract class DailyExhangeUsecase {
  Future<Either<FailureSearch, DailyExchangeEntity>> call({
    required String fromSymbol,
  });
}

class DailyExhangeUsecaseImpl implements DailyExhangeUsecase {
  final ExchangeRepository repository;
  Logger logger;

  DailyExhangeUsecaseImpl({required this.repository, required this.logger});

  @override
  Future<Either<FailureSearch, DailyExchangeEntity>> call({
    required String fromSymbol,
  }) async {
    logger.d('Inicio do usecase na domain para daily exchange.');
    try {
      return await repository.daily(fromSymbol: fromSymbol);
    } on Exception {
      return Left(InvalidResponseFailure());
    }
  }
}
