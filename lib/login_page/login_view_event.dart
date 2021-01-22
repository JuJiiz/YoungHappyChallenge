import 'package:younghappychallenge/core/base/base_view_event.dart';

class LoginSuccessViewState implements BaseViewEvent {
  final bool shouldRegister;

  LoginSuccessViewState(this.shouldRegister);
}
