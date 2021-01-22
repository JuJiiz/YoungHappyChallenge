import 'package:firebase_auth/firebase_auth.dart';
import 'package:younghappychallenge/core/api_service.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/user/model/response_my_profile.dart';
import 'package:younghappychallenge/user/model/user_entity.dart';
import 'package:younghappychallenge/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;
  final APIService _apiService;

  UserRepositoryImpl(this._auth, this._apiService);

  @override
  Future<Result<ResponseMyProfile>> requestMyProfile() async {
    final token = await _auth.currentUser?.getIdToken();
    if (token != null) {
      final response = await _apiService.requestMyProfile(token);

      if (response.success) {
        final String refCode = response.data['ref_code'] as String;
        final double sumPoint = response.data['sum_point'] as double;
        final double sumTime = response.data['sum_time'] as double;
        final UserEntity user =
            UserEntity.fromJson(response.data['user'] as Map);

        return Success(
          ResponseMyProfile(
            refCode: refCode,
            sumPoint: sumPoint,
            sumTime: sumTime,
            user: user,
          ),
        );
      } else {
        return Failure(response.message);
      }
    } else {
      return Failure('User token not found.');
    }
  }
}
