import 'package:dartz/dartz.dart';
import 'package:exchange_app/app/core/errors/errors.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/current_exchange_entity.dart';
import 'package:exchange_app/app/modules/exchange/domain/repositories/exchange_repository.dart';
import 'package:exchange_app/app/modules/exchange/domain/usecases/current_exchange_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MovieRepositoryMock extends Mock implements ExchangeRepository {}

class LoggerMock extends Mock implements Logger {}

void main() {
  final repository = MovieRepositoryMock();
  final logger = LoggerMock();
  final usecase =
      CurrentExhangeUsecaseImpl(repository: repository, logger: logger);

  const fromSymbol = '2';

  test('should return a current exchange', () async {
    // Arrange
    final CurrentExchangeEntity currentExchangeEntity = CurrentExchangeEntity(
        exchangeRate: 1, fromSymbol: '2', lastUpdatedAt: '3', toSymbol: '4');

    when(() => repository.current(fromSymbol: fromSymbol))
        .thenAnswer((_) async => Right(currentExchangeEntity));

    // Act
    final result = await usecase(fromSymbol: fromSymbol);

    // Assert
    expect(result.isRight(), true);
    expect(
        result.getOrElse(() => CurrentExchangeEntity(
            exchangeRate: 0, fromSymbol: '', lastUpdatedAt: '', toSymbol: '')),
        isA<CurrentExchangeEntity>());
  });

  test('should return a FailureSearch on error', () async {
    // Arrange
    when(() => repository.current(fromSymbol: fromSymbol))
        .thenAnswer((_) async => Left(InvalidResponseFailure()));

    // Act
    final result = await usecase(fromSymbol: fromSymbol);

    // Assert
    expect(result.isLeft(), true);
    expect(result.fold(id, (_) => null), isA<FailureSearch>());
  });
}
