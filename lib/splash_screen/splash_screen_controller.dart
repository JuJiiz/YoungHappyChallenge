import 'dart:async';

import 'package:younghappychallenge/authentication/authentication_repository.dart';
import 'package:younghappychallenge/authentication/user_session.dart';
import 'package:younghappychallenge/core/base/base_controller.dart';

class SplashScreenController extends BaseController {
  final AuthenticationRepository _authenticationRepository;

  SplashScreenController(this._authenticationRepository);

  StreamController _sessionController = StreamController<UserSession>();

  Stream<UserSession> get sessionStream => _sessionController.stream;

  _checkUserSession() {
    UserSession session = _authenticationRepository.checkAuth();
    _sessionController.sink.add(session);
  }

  @override
  init() {
    _checkUserSession();
  }

  @override
  dispose() {
    _sessionController.close();
  }
}
