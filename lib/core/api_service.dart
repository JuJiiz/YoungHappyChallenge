import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:younghappychallenge/core/base/base_remote_response.dart';
import 'package:younghappychallenge/core/constants.dart';
import 'package:younghappychallenge/core/network_utils.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/login_page/model/input_send_otp.dart';
import 'package:younghappychallenge/login_page/model/input_validate_user.dart';
import 'package:younghappychallenge/login_page/model/input_verify_otp.dart';

class APIService {
  final String _endpoint;

  APIService({@required endpoint}) : _endpoint = endpoint;

  Future<Result<String>> requestBuilderName() {
    return Future.value(Success(builder_name));
  }

  Future<BaseRemoteResponse> requestSendOTP(InputSendOTP input) async {
    final url = Uri.https(_endpoint, 'send-otp');

    final body = json.encode(input.toMap());

    try {
      final response = await NetworkUtils.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {
      return BaseRemoteResponse(success: false, data: null, message: e.message);
    }
  }

  Future<BaseRemoteResponse> requestVerifyOTP(InputVerifyOTP input) async {
    final url = Uri.https(_endpoint, 'verify-otp');

    final body = json.encode(input.toMap());

    try {
      final response = await NetworkUtils.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {
      return BaseRemoteResponse(success: false, data: null, message: e.message);
    }
  }

  Future<BaseRemoteResponse> requestValidateUser(
      InputValidateUser input) async {
    final url = Uri.https(_endpoint, 'validate');

    final body = json.encode(input.toMap());

    try {
      final response = await NetworkUtils.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      return response;
    } catch (e) {
      return BaseRemoteResponse(success: false, data: null, message: e.message);
    }
  }

  Future<BaseRemoteResponse> requestCountry() async {
    final url = Uri.https(_endpoint, 'country/get');

    try {
      final response = await NetworkUtils.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      return response;
    } catch (e) {
      return BaseRemoteResponse(success: false, data: null, message: e.message);
    }
  }

  Future<BaseRemoteResponse> requestMyProfile(String token) async {
    final url = Uri.https(_endpoint, 'user/my-profile', {'community_id': '1'});

    final response = await NetworkUtils.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}
