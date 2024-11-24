import 'package:flutter_dotenv/flutter_dotenv.dart';
class ConfigEnv {
  static String basePath = 'https://api-brl-exchange.actionlabs.com.br/api/1.0/open';
  static String currentPath = '/currentExchangeRate';
  static String dailyPath = '/dailyExchangeRate';
  static String apiKey = dotenv.env['API_KEY']!;
  static String toSymbol= dotenv.env['TO_SYMBOL']!;
}