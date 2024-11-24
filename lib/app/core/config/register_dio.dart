import 'package:dio/dio.dart';

import 'config_env.dart';

Dio registerDio() {
  final dio = Dio();
  dio.options.baseUrl = ConfigEnv.basePath;
  dio.options.queryParameters = {
    'api_key': ConfigEnv.apiKey,
    'to_symbol': ConfigEnv.toSymbol
  };

  return dio;
}
