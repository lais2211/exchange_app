abstract class FailureSearch implements Exception {}

class InvalidResponseFailure extends FailureSearch {}

class DataSourceFailure extends FailureSearch {
  final String? errorMessage;
  final int? errorCode;

  DataSourceFailure({this.errorMessage = 'Error', this.errorCode = 0});  
}

class InternalServerError implements DataSourceFailure {
  final String message;

  InternalServerError(this.message);

  @override
  int? get errorCode => 500;

  @override
  String get errorMessage => message;
}