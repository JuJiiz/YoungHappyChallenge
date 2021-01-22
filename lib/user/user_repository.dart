import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/user/model/response_my_profile.dart';

abstract class UserRepository {
  Future<Result<ResponseMyProfile>> requestMyProfile();
}
