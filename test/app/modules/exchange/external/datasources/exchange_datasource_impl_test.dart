import 'package:dio/dio.dart';
import 'package:exchange_app/app/core/config/config_env.dart';
import 'package:exchange_app/app/core/errors/errors.dart';
import 'package:exchange_app/app/modules/exchange/external/datasources/exchange_datasource_impl.dart';
import 'package:exchange_app/app/modules/exchange/infra/models/current_exchange_model.dart';
import 'package:exchange_app/app/modules/exchange/infra/models/daily_exchange_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/mock.dart';

class DioMock extends Mock implements Dio {}

class LoggerMock extends Mock implements Logger {}

void main() async {
  final dio = DioMock();
  final logger = LoggerMock();
  final datasource = ExchangeDatasourceImpl(dio: dio, logger: logger);
  const apiKey = '12345';
  const from_symbol = '2';
  const to_symbol = '4';

  test('should return a current exchange', () async {
    // Arrange
    when(() => dio.get(ConfigEnv.currentPath,
            queryParameters: {'from_symbol': from_symbol}))
        .thenAnswer((_) async => Response<Map<String, Object>>(
              data: currentResult,
              requestOptions: RequestOptions(),
              statusCode: 200,
            ));

    // Act
    final result = await datasource.getCurrentExchange(
        fromSymbol: from_symbol, toSymbol: to_symbol, apiKey: apiKey);

    // Assert
    expect(result, isA<CurrentExchangeModel>());
  });

  test('should return an error when fetching current exchange', () async {
    // Arrange

    when(() => dio.get(
          ConfigEnv.currentPath,
          queryParameters: {'from_symbol': from_symbol},
        )).thenAnswer((_) async => Response<Map<String, dynamic>>(
          data: null,
          requestOptions: RequestOptions(),
          statusCode: 400,
        ));

    // Act
    final future = datasource.getCurrentExchange(
        fromSymbol: from_symbol, toSymbol: to_symbol, apiKey: apiKey);

    // Assert
    expect(future, throwsA(isA<DataSourceFailure>()));
  });

  test('should return a daily exchange', () async {
    // Arrange
    when(() => dio.get(ConfigEnv.dailyPath,
            queryParameters: {'from_symbol': from_symbol}))
        .thenAnswer((_) async => Response<Map<String, Object>>(
              data: dailyResult,
              requestOptions: RequestOptions(),
              statusCode: 200,
            ));

    // Act
    final result = await datasource.getDailyExchange(
        fromSymbol: from_symbol, toSymbol: to_symbol, apiKey: apiKey);

    // Assert
    expect(result, isA<DailyExchangeModel>());
  });

  test('should return an error when fetching daily exchange', () async {
    // Arrange

    when(() => dio.get(
          ConfigEnv.dailyPath,
          queryParameters: {'from_symbol': from_symbol},
        )).thenAnswer((_) async => Response<Map<String, dynamic>>(
          data: null,
          requestOptions: RequestOptions(),
          statusCode: 400,
        ));

    // Act
    final future = datasource.getDailyExchange(
        fromSymbol: from_symbol, toSymbol: to_symbol, apiKey: apiKey);

    // Assert
    expect(future, throwsA(isA<DataSourceFailure>()));
  });
}
