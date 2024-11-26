import 'package:bloc/bloc.dart';
import 'package:exchange_app/app/modules/exchange/domain/usecases/current_exchange_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/entities/current_exchange_entity.dart';

part 'current_state.dart';

class CurrentCubit extends Cubit<CurrentState> {
  CurrentCubit() : super(CurrentInitial());
  final CurrentExhangeUsecase usecase = Modular.get();

  Future<void> getCurrentExchange(String fromSymbol) async {
    emit(CurrentLoading());
    try {
      if (fromSymbol.isEmpty) {
        emit(CurrentError());
      } else {
        final response = await usecase(fromSymbol: fromSymbol);

        response.fold(
          (l) => emit(CurrentError()),
          (r) => emit(
            CurrentSucess(r),
          ),
        );
      }
    } catch (e) {
      emit(CurrentError());
    }
  }
}
