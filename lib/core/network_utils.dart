import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:younghappychallenge/core/base/base_remote_response.dart';

class NetworkUtils {
  static Future<BaseRemoteResponse> get(
      Uri url, {
        Map<String, String> headers,
      }) async {
    try {
      final response = await http.get(url, headers: headers);
      final body = response.body;
      final statusCode = response.statusCode;
      if (body == null) {
        return BaseRemoteResponse(
          success: false,
          message: 'Response body is null',
        );
        //throw RemoteDataSourceException(statusCode, 'Response body is null');
      }
      final decoded = json.decode(body);
      if (statusCode < 200 || statusCode >= 300) {
        return BaseRemoteResponse(
          success: false,
          message: decoded['message'],
        );
        //throw RemoteDataSourceException(statusCode, decoded['message']);
      }

      return BaseRemoteResponse.fromJson(decoded);
    } on SocketException {
      return BaseRemoteResponse(
        success: false,
        message: 'Internet connection failed.',
      );
      //throw RemoteConnectionException('No Internet connection');
    }
  }

  static Future<BaseRemoteResponse> post(
      Uri url, {
        Map<String, String> headers,
        Map<String, String> bodyField,
        String body,
      }) =>
      _helper(
        'POST',
        url,
        headers: headers,
        bodyField: bodyField,
        body: body,
      );

  static Future<BaseRemoteResponse> _helper(
      String method,
      Uri url, {
        Map<String, String> headers,
        Map<String, String> bodyField,
        String body,
      }) async {
    try {
      final request = http.Request(method, url);
      if (body != null) {
        request.body = body;
      }
      if (bodyField != null) {
        request.bodyFields = bodyField;
      }
      if (headers != null) {
        request.headers.addAll(headers);
      }
      final streamedResponse = await request.send();

      final decoded =
      json.decode(await streamedResponse.stream.bytesToString());

      final statusCode = streamedResponse.statusCode;
      if (statusCode < 200 || statusCode >= 300) {
        return BaseRemoteResponse(
          success: false,
          message: decoded['message'],
        );
        //throw RemoteDataSourceException(statusCode, decoded['message']);
      }

      return BaseRemoteResponse.fromJson(decoded);
    } on SocketException {
      return BaseRemoteResponse(
        success: false,
        message: 'Internet connection failed.',
      );
      //throw RemoteConnectionException('No Internet connection');
    }
  }

  static Future<BaseRemoteResponse> put(
      Uri url, {
        Map<String, String> headers,
        body,
      }) =>
      _helper(
        'PUT',
        url,
        headers: headers,
        body: body,
      );
}
