import 'package:exchange_app/app/modules/exchange/domain/repositories/exchange_repository.dart';
import 'package:exchange_app/app/modules/exchange/domain/usecases/current_exchange_usecase.dart';
import 'package:exchange_app/app/modules/exchange/external/datasources/exchange_datasource_impl.dart';
import 'package:exchange_app/app/modules/exchange/infra/datasource/exchange_datasource.dart';
import 'package:exchange_app/app/modules/exchange/presenter/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/config/register_dio.dart';
import '../../core/config/register_logger.dart';
import 'domain/usecases/daily_exchange_usecase.dart';
import 'infra/repositories/exchange_repository_impl.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add(() => registerDio());
    i.add(() => registerLogger());
    i.add<ExchangeDatasource>(ExchangeDatasourceImpl.new);
    i.add<ExchangeRepository>(ExchangeRepositoryImpl.new);
    i.add<CurrentExhangeUsecase>(CurrentExhangeUsecaseImpl.new);
    i.add<DailyExhangeUsecase>(DailyExhangeUsecaseImpl.new);
  }

  @override
  void routes(r) {
     r.child('/', child: (context) => const HomePage());
  }
}
