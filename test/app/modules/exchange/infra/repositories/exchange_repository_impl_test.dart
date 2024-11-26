import 'package:dartz/dartz.dart';
import 'package:exchange_app/app/core/errors/errors.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/current_exchange_entity.dart';
import 'package:exchange_app/app/modules/exchange/domain/entities/daily_exchange_entity.dart';
import 'package:exchange_app/app/modules/exchange/infra/datasource/exchange_datasource.dart';
import 'package:exchange_app/app/modules/exchange/infra/models/current_exchange_model.dart';
import 'package:exchange_app/app/modules/exchange/infra/models/daily_exchange_model.dart';
import 'package:exchange_app/app/modules/exchange/infra/repositories/exchange_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class ExchangeDataSourceMock extends Mock implements ExchangeDatasource {}

class LoggerMock extends Mock implements Logger {}

void main() {
  final datasource = ExchangeDataSourceMock();
  final logger = LoggerMock();

  const fromSymbol = '2';

  final repository =
      ExchangeRepositoryImpl(datasource: datasource, logger: logger);

  test('should return a current exchange', () async {
    // Arrange
    final currentExchangeModel = CurrentExchangeModel(
        exchangeRate: 2.2, fromSymbol: '', lastUpdatedAt: '', toSymbol: '');

    when(() => datasource.getCurrentExchange(
          fromSymbol: fromSymbol,
        )).thenAnswer((_) async => currentExchangeModel);

    // Act
    final result = await repository.current(
      fromSymbol: fromSymbol,
    );

    // Assert
    expect(result.isRight(), true);
    expect(
        result.getOrElse(() => CurrentExchangeEntity(
            exchangeRate: 0, fromSymbol: '', lastUpdatedAt: '', toSymbol: '')),
        isA<CurrentExchangeEntity>());
  });

  test(
      'should return a DataSourceFailure when getCurrentExchange throws an Exception',
      () async {
    // Arrange
    when(() => datasource.getCurrentExchange(
          fromSymbol: fromSymbol,
        )).thenThrow(Exception());

    // Act
    final result = await repository.current(
      fromSymbol: fromSymbol,
    );

    // Assert
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<DataSourceFailure>());
  });

  test('should return a daily exchange', () async {
    // Arrange
    final dailyExchangeModel = DailyExchangeModel(
        dailyExchangeRateEntity: [], from: '1', lastUpdatedAt: '2', to: '3');

    when(() => datasource.getDailyExchange(
          fromSymbol: fromSymbol,
        )).thenAnswer((_) async => dailyExchangeModel);

    // Act
    final result = await repository.daily(
      fromSymbol: fromSymbol,
    );

    // Assert
    expect(result.isRight(), true);
    expect(
        result.getOrElse(() => DailyExchangeEntity(
            dailyExchangeRateEntity: [], from: '', lastUpdatedAt: '', to: '')),
        isA<DailyExchangeEntity>());
  });

  test(
      'should return a DataSourceFailure when getCurrentExchange throws an Exception',
      () async {
    // Arrange
    when(() => datasource.getCurrentExchange(
          fromSymbol: fromSymbol,
        )).thenThrow(Exception());

    // Act
    final result = await repository.current(
      fromSymbol: fromSymbol,
    );

    // Assert
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<DataSourceFailure>());
  });
}
