import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:younghappychallenge/core/base/base_page.dart';
import 'package:younghappychallenge/home_page/home.dart';
import 'package:younghappychallenge/login_page/login.dart';
import 'package:younghappychallenge/register_page/register.dart';
import 'package:younghappychallenge/splash_screen/splash_checking_result.dart';
import 'package:younghappychallenge/splash_screen/splash_screen.dart';

// ignore: must_be_immutable
class SplashScreenPage extends BasePage<SplashScreenController> {
  static const routeName = '/';

  SplashScreenPage(context, controller) : super(context, controller);

  StreamSubscription _subscription;

  @override
  void onStateInit() {
    super.onStateInit();
    controller.init();

    _subscription = controller.sessionStream
        .throttleTime(Duration(milliseconds: 3000))
        .listen((SplashCheckingResult result) {
      switch (result) {
        case SplashCheckingResult.SessionNotFound:
          {
            Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            break;
          }
        case SplashCheckingResult.UserNotSatisfied:
          {
            Navigator.of(context).pushReplacementNamed(RegisterPage.routeName);
            break;
          }
        case SplashCheckingResult.AllPass:
          {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            break;
          }
      }
    });
  }

  @override
  void onDispose() {
    _subscription.cancel();

    controller.dispose();
    super.onDispose();
  }

  @override
  Widget initUI(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('Splash Screen'),
      ),
    );
  }
}
