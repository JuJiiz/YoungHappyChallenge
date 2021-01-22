import 'package:younghappychallenge/authentication/user_session.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/login_page/model/input_send_otp.dart';
import 'package:younghappychallenge/login_page/model/input_validate_user.dart';
import 'package:younghappychallenge/login_page/model/input_verify_otp.dart';

abstract class AuthenticationRepository {
  UserSession checkAuth();

  Future<Result<String>> requestSendOTP(InputSendOTP input);

  Future<Result<bool>> requestVerifyOTP(InputVerifyOTP input);

  Future<Result<bool>> requestValidateUser(InputValidateUser input);
}
