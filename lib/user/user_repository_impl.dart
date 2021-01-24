import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:universal_html/html.dart' as html;
import 'package:younghappychallenge/core/api_service.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/core/storage_service.dart';
import 'package:younghappychallenge/register_page/model/input_user_register.dart';
import 'package:younghappychallenge/register_page/model/profile_image_model.dart';
import 'package:younghappychallenge/user/model/request_register_user.dart';
import 'package:younghappychallenge/user/model/response_my_profile.dart';
import 'package:younghappychallenge/user/model/user_entity.dart';
import 'package:younghappychallenge/user/my_profile_store.dart';
import 'package:younghappychallenge/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;
  final StorageService _storageService;
  final APIService _apiService;
  final MyProfileProvider _myProfileProvider;

  UserRepositoryImpl(
    this._auth,
    this._storageService,
    this._apiService,
    this._myProfileProvider,
  );

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

        final ResponseMyProfile _myProfile = ResponseMyProfile(
          refCode: refCode,
          sumPoint: sumPoint,
          sumTime: sumTime,
          user: user,
        );

        _myProfileProvider.updateMyProfile(_myProfile);

        return Success(_myProfile);
      } else {
        return Failure(response.message);
      }
    } else {
      return Failure('User token not found.');
    }
  }

  @override
  Future<Result> requestRegisterUser(InputUserRegister input) async {
    String _imageURL;
    final uid = _auth.currentUser?.uid;
    try {
      if (uid != null) {
        if (input.profilePicture is ProfileMobileImageModel) {
          final String path =
              (input.profilePicture as ProfileMobileImageModel).path;
          final Result<String> result =
              await _storageService.uploadProfileFromMobileImage(path, uid);
          if (result is Success<String>) _imageURL = result.data;
        } else if (input.profilePicture is ProfileWebImageModel) {
          final html.File file =
              (input.profilePicture as ProfileWebImageModel).file;
          final Result<String> result =
              await _storageService.uploadProfileFromWebImage(file, uid);
          if (result is Success<String>) _imageURL = result.data;
        }
      }
    } catch (e) {
      log('upload image error: ${e.message}');
    }

    final token = await _auth.currentUser?.getIdToken();
    if (token != null) {
      final RequestRegisterUser request = RequestRegisterUser(
        displayName: input.displayName,
        imageURL: _imageURL,
        countryID: input.country.id,
        dateOfBirth: DateTime(
          input.birthDate.yearNumber,
          input.birthDate.monthNumber,
          input.birthDate.dayNumber,
        ),
        gender: input.gender.value,
      );

      final response = await _apiService.requestRegisterUser(token, request);

      if (response.success) {
        return Success();
      } else {
        return Failure(response.message);
      }
    } else {
      return Failure('User token not found.');
    }
  }
}
