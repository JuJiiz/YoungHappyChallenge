import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:younghappychallenge/core/base/base_remote_response.dart';
import 'package:younghappychallenge/core/constants.dart';
import 'package:younghappychallenge/core/network_utils.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/login_page/model/input_send_otp.dart';

class APIService {
  final String _endpoint;

  APIService({@required endpoint}) : _endpoint = endpoint;

  Future<Result<String>> requestBuilderName() {
    return Future.value(Success(builder_name));
  }

  Future<BaseRemoteResponse> requestSendOTP(InputSendOTP input) async {
    final url = Uri.https(_endpoint, 'send-otp');

    final body = json.encode(input.toMap());

    final response = await NetworkUtils.post(
      url,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
