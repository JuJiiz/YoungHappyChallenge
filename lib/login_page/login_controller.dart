import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:younghappychallenge/authentication/authentication_repository.dart';
import 'package:younghappychallenge/core/base/base_controller.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/login_page/login.dart';
import 'package:younghappychallenge/login_page/model/input_send_otp.dart';
import 'package:younghappychallenge/login_page/widget/login_phone_section_view.dart';

class LoginController extends BaseController {
  final AuthenticationRepository _authenticationRepository;

  LoginController(this._authenticationRepository);

  StreamController _isLoadingController = StreamController<bool>();

  StreamController _loginSectionController = StreamController<LoginSection>();

  Stream<Widget> get loginSection => _initialLoginWidgetBySection();

  String _otpRef;

  Stream<Widget> _initialLoginWidgetBySection() {
    return _loginSectionController.stream.map((section) {
      if (section is LoginPhoneSection) {
        return LoginPhoneSectionView(onSendOTP: _requestSendOTP);
      } else if (section is LoginOTPSection) {
        return Text('LoginOTPSection');
      } else {
        return Text('Invalid section');
      }
    });
  }

  _requestSendOTP(String calling, String phone) async {
    log('calling : $calling || phone: $phone');

    final InputSendOTP input = InputSendOTP(phone, calling);
    final Result<String> result =
        await _authenticationRepository.requestSendOTP(input);
    if (result is Success<String>) {
      _otpRef = result.data;
      _loginSectionController.sink.add(LoginOTPSection());
    } else {}
  }

  @override
  init() {
    isLoading = _isLoadingController.stream;

    _loginSectionController.sink.add(LoginPhoneSection());
  }

  @override
  dispose() {
    _isLoadingController.close();
    _loginSectionController.close();
  }
}
