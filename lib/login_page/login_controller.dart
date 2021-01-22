import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:younghappychallenge/authentication/authentication_repository.dart';
import 'package:younghappychallenge/core/base/base_controller.dart';
import 'package:younghappychallenge/core/base/base_view_event.dart';
import 'package:younghappychallenge/core/result.dart';
import 'package:younghappychallenge/login_page/login.dart';
import 'package:younghappychallenge/login_page/login_view_event.dart';
import 'package:younghappychallenge/login_page/model/input_send_otp.dart';
import 'package:younghappychallenge/login_page/model/input_validate_user.dart';
import 'package:younghappychallenge/login_page/model/input_verify_otp.dart';
import 'package:younghappychallenge/login_page/widget/login_otp_section_view.dart';
import 'package:younghappychallenge/login_page/widget/login_phone_section_view.dart';

class LoginController extends BaseController {
  final AuthenticationRepository _authenticationRepository;

  LoginController(this._authenticationRepository);

  StreamController _loginSectionController = StreamController<LoginSection>();

  Stream<Widget> get loginSection => _initialLoginWidgetBySection();

  String _currentPhoneNumber;
  String _currentCallingCode;
  String _otpRef;

  Stream<Widget> _initialLoginWidgetBySection() {
    return _loginSectionController.stream.map((section) {
      if (section is LoginPhoneSection) {
        return LoginPhoneSectionView(onSendOTP: _requestSendOTP);
      } else if (section is LoginOTPSection) {
        return LoginOTPSectionView(
          onVerifyOTP: _requestVerifyOTP,
          onResendOTP: _requestReSendOTP,
        );
      } else {
        return Text('Invalid section');
      }
    });
  }

  _requestSendOTP(String calling, String phone) async {
    log('calling : $calling || phone: $phone');

    _currentPhoneNumber = phone;
    _currentCallingCode = calling.replaceFirst('+', '');

    setViewState(OperatingViewState());

    final InputSendOTP input = InputSendOTP(phone, calling);
    final Result<String> result =
        await _authenticationRepository.requestSendOTP(input);
    if (result is Success<String>) {
      setViewState(NormalViewState());

      _otpRef = result.data;
      _loginSectionController.sink.add(LoginOTPSection());
    } else {
      setViewState(ErrorViewState((result as Failure).message));
    }
  }

  _requestReSendOTP() async {
    log('resend calling : $_currentCallingCode || phone: $_currentPhoneNumber');

    setViewState(OperatingViewState());

    if (_currentCallingCode != null && _currentPhoneNumber != null) {
      final InputSendOTP input =
          InputSendOTP(_currentCallingCode, _currentPhoneNumber);
      final Result<String> result =
          await _authenticationRepository.requestSendOTP(input);
      if (result is Success<String>) {
        _otpRef = result.data;
        setViewState(NormalViewState());
      } else {
        setViewState(ErrorViewState((result as Failure).message));
      }
    } else {
      setViewState(ErrorViewState('Phone number not found.'));
    }
  }

  _requestVerifyOTP(String otpCode) async {
    log('ref : $_otpRef || code: $otpCode');

    setViewState(OperatingViewState());

    final InputVerifyOTP input = InputVerifyOTP(_otpRef, otpCode);
    final Result<bool> result =
        await _authenticationRepository.requestVerifyOTP(input);
    if (result is Success<bool>) {
      _requestValidateUser();
    } else {
      setViewState(ErrorViewState((result as Failure).message));
    }
  }

  _requestValidateUser() async {
    log('validate user => calling : $_currentCallingCode || phone: $_currentPhoneNumber');

    setViewState(OperatingViewState());

    if (_currentCallingCode != null && _currentPhoneNumber != null) {
      final InputValidateUser input = InputValidateUser(
        _currentPhoneNumber,
        _currentCallingCode,
      );
      final Result<bool> result =
          await _authenticationRepository.requestValidateUser(input);
      if (result is Success<bool>) {
        setViewState(LoginSuccessViewState(result.data));
      } else {
        setViewState(ErrorViewState((result as Failure).message));
      }
    } else {
      setViewState(ErrorViewState('Phone number not found.'));
    }
  }

  @override
  init() {
    _loginSectionController.sink.add(LoginPhoneSection());
  }

  @override
  dispose() {
    _loginSectionController.close();
  }
}
