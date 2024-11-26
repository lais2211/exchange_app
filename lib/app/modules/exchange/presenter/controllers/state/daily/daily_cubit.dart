import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/entities/daily_exchange_entity.dart';
import '../../../../domain/usecases/daily_exchange_usecase.dart';

part 'daily_state.dart';

class DailyCubit extends Cubit<DailyState> {
  DailyCubit() : super(DailyInitial());
  final DailyExhangeUsecase usecase = Modular.get();

  Future<void> getDailyExchange(String fromSymbol) async {
    emit(DailyLoading());
    try {
      final response = await usecase(fromSymbol: fromSymbol);

      response.fold(
        (l) => emit(DailyError()),
        (r) => emit(
          DailySucess(r),
        ),
      );
    } catch (e) {
      emit(DailyError());
    }
  }
}
