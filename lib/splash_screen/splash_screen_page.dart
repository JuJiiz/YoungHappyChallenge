import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:younghappychallenge/authentication/user_session.dart';
import 'package:younghappychallenge/core/base/base_page.dart';
import 'package:younghappychallenge/home_page/home.dart';
import 'package:younghappychallenge/login_page/login.dart';
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
        .listen((UserSession session) {
      if (session is SessionFound) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
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
