import 'dart:async';

import 'package:flutter/material.dart';
import 'package:younghappychallenge/core/base/base_page.dart';
import 'package:younghappychallenge/core/base/base_view_event.dart';
import 'package:younghappychallenge/home_page/home.dart';
import 'package:younghappychallenge/login_page/login.dart';
import 'package:younghappychallenge/login_page/login_view_event.dart';
import 'package:younghappychallenge/register_page/register.dart';

class LoginPage extends BasePage<LoginController> {
  static const routeName = '/login';

  LoginPage(BuildContext context, controller) : super(context, controller);

  List<StreamSubscription> _subscriptions;

  @override
  void onStateInit() {
    super.onStateInit();
    controller.init();

    _subscriptions = [
      controller.viewState.listen((BaseViewEvent viewState) {
        if (viewState is LoginSuccessViewState) {
          if (viewState.shouldRegister) {
            Navigator.of(context).pushReplacementNamed(RegisterPage.routeName);
          } else {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          }
        }
      })
    ];
  }

  @override
  void onDispose() {
    _subscriptions?.forEach((s) => s.cancel());
    controller.dispose();
    super.onDispose();
  }

  @override
  Widget initUI(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Login Screen'),
            StreamBuilder(
                stream: controller.loginSection,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Widget> snapshot,
                ) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    child: snapshot.hasData ? snapshot.data : SizedBox(),
                  );
                }),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
