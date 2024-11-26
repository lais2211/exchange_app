part of 'daily_cubit.dart';

abstract class DailyState {}

class DailyInitial extends DailyState {}

class DailyLoading extends DailyState {}

class DailyError extends DailyState {}

class DailySucess extends DailyState {
  DailySucess(this.daily);

  final DailyExchangeEntity daily;
}
