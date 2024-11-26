import 'package:dio/dio.dart';

import 'config_env.dart';
import 'inteceptor.dart';

Dio registerDio() {
  final dio = Dio();
  dio.interceptors.add(LoggerInterceptor());
  dio.options.baseUrl = ConfigEnv.basePath;
  dio.options.queryParameters = {
    'apiKey': ConfigEnv.apiKey,
    'to_symbol': ConfigEnv.toSymbol
  };

  return dio;
}
