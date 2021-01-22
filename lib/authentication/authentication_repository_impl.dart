import 'package:firebase_auth/firebase_auth.dart';
import 'package:younghappychallenge/authentication/authentication_repository.dart';
import 'package:younghappychallenge/authentication/user_session.dart';
import 'package:younghappychallenge/core/api_service.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/login_page/model/input_send_otp.dart';
import 'package:younghappychallenge/login_page/model/input_validate_user.dart';
import 'package:younghappychallenge/login_page/model/input_verify_otp.dart';
import 'package:younghappychallenge/login_page/model/response_validate_user.dart';

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
    final response = await _apiService.requestSendOTP(input);

    if (response.success) {
      final String otpRef = (response.data['otp_ref'] as String);
      return Success(otpRef);
    } else {
      return Failure(response.message);
    }
  }

  @override
  Future<Result<bool>> requestVerifyOTP(InputVerifyOTP input) async {
    final response = await _apiService.requestVerifyOTP(input);

    if (response.success) {
      return Success(response.success);
    } else {
      return Failure(response.message);
    }
  }

  @override
  Future<Result<bool>> requestValidateUser(
    InputValidateUser input,
  ) async {
    final response = await _apiService.requestValidateUser(input);
    if (response.success) {
      final String token = (response.data['custom_token'] as String);
      final bool shouldRegister = (response.data['is_register'] as bool);

      if (token != null) {
        final resultData = ResponseValidateUser(token, shouldRegister);

        final UserCredential credential =
            await _auth.signInWithCustomToken(resultData.customToken);

        if (credential != null)
          return Success(shouldRegister);
        else
          return Failure('Login Failed. About credential');
      } else
        return Failure('Login Failed. Token not found.');
    } else {
      return Failure(response.message);
    }
  }
}
