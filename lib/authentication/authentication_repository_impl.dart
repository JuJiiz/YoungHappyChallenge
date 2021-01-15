import 'package:firebase_auth/firebase_auth.dart';
import 'package:younghappychallenge/authentication/authentication_repository.dart';
import 'package:younghappychallenge/authentication/user_session.dart';
import 'package:younghappychallenge/core/api_service.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/login_page/model/input_send_otp.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final APIService _apiService;
  final FirebaseAuth _auth;

  AuthenticationRepositoryImpl(this._apiService, this._auth);

  @override
  UserSession checkAuth() {
    User currentUser = _auth.currentUser;
    return _auth.currentUser != null
        ? SessionFound(currentUser.uid)
        : SessionNotFound();
  }

  @override
  Future<Result<String>> requestSendOTP(InputSendOTP input) async {
    final requestOTPResponse = await _apiService.requestSendOTP(input);

    final String otpRef = (requestOTPResponse.data['otp_ref'] as String);

    if (requestOTPResponse.success) {
      return Success(otpRef);
    } else {
      return Failure(requestOTPResponse.message);
    }
  }
}
