import 'package:rxdart/rxdart.dart';
import 'package:younghappychallenge/authentication/authentication_repository.dart';
import 'package:younghappychallenge/authentication/user_session.dart';
import 'package:younghappychallenge/core/base/base_controller.dart';
import 'package:younghappychallenge/core/base/base_view_event.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/splash_screen/splash_checking_result.dart';
import 'package:younghappychallenge/user/model/response_my_profile.dart';
import 'package:younghappychallenge/user/model/user_entity.dart';
import 'package:younghappychallenge/user/user_repository.dart';

class SplashScreenController extends BaseController {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  SplashScreenController(this._authenticationRepository, this._userRepository);

  BehaviorSubject<SplashCheckingResult> sessionStream =
      BehaviorSubject<SplashCheckingResult>();

  _checkUserSession() async {
    final UserSession session = _authenticationRepository.checkAuth();

    if (session is SessionFound) {
      final Result<ResponseMyProfile> result =
          await _userRepository.requestMyProfile();
      if (result is Success<ResponseMyProfile>) {
        if (_checkUserIsSatisfied(result.data.user)) {
          sessionStream.sink.add(SplashCheckingResult.AllPass);
        } else {
          sessionStream.sink.add(SplashCheckingResult.UserNotSatisfied);
        }
      } else {
        final String message = (result as Failure).message;
        setViewState(ErrorViewState(message));
      }
    } else {
      sessionStream.sink.add(SplashCheckingResult.SessionNotFound);
    }
  }

  bool _checkUserIsSatisfied(UserEntity user) {
    final isDisplayNameSatisfy =
        user.displayName != null && user.displayName.isNotEmpty;

    return isDisplayNameSatisfy;
  }

  @override
  init() {
    _checkUserSession();
  }

  @override
  dispose() {
    sessionStream.close();
  }
}
