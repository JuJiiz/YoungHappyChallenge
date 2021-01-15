import 'package:younghappychallenge/authentication/user_session.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/login_page/model/input_send_otp.dart';

abstract class AuthenticationRepository {
  UserSession checkAuth();

  Future<Result<String>> requestSendOTP(InputSendOTP input);
}
