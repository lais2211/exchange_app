part of 'current_cubit.dart';

abstract class CurrentState {}

class CurrentInitial extends CurrentState {}

class CurrentLoading extends CurrentState {}

class CurrentError extends CurrentState {}

class CurrentSucess extends CurrentState {
  CurrentSucess(this.current);

  final CurrentExchangeEntity current;
}
