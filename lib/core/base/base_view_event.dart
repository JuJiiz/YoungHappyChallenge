abstract class BaseViewEvent {}

class NormalViewState implements BaseViewEvent {}

class OperatingViewState implements BaseViewEvent {
  final String message;

  OperatingViewState({this.message = 'Loading...'});
}

class ErrorViewState implements BaseViewEvent {
  final String message;

  ErrorViewState(this.message);
}
