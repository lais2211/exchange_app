import 'package:dartz/dartz.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/current_exchange_entity.dart';
import 'package:exchange_app/app/modules/exchange/domain/repositories/exchange_repository.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/errors.dart';

abstract class CurrentExhangeUsecase {
  Future<Either<FailureSearch, CurrentExchangeEntity>> call(
      {required String apiKey,
      required String from_symbol,
      required String to_symbol});
}

class CurrentExhangeUsecaseImpl implements CurrentExhangeUsecase {
  final ExchangeRepository repository;
  Logger logger;

  CurrentExhangeUsecaseImpl({required this.repository, required this.logger});

  @override
  Future<Either<FailureSearch, CurrentExchangeEntity>> call(
      {required String apiKey,
      required String from_symbol,
      required String to_symbol}) async {
    logger.d('Inicio do usecase na domain para current exchange.');
    try {
      return await repository.current(
          apiKey: apiKey, from_symbol: from_symbol, to_symbol: to_symbol);
    } on Exception {
      return Left(InvalidResponseFailure());
    }
  }
}
