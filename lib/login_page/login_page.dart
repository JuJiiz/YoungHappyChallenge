import 'package:flutter/material.dart';
import 'package:younghappychallenge/core/base/base_page.dart';
import 'package:younghappychallenge/home_page/home.dart';
import 'package:younghappychallenge/login_page/login.dart';

class LoginPage extends BasePage<LoginController> {
  static const routeName = '/login';

  LoginPage(BuildContext context, controller) : super(context, controller);

  @override
  void onStateInit() {
    super.onStateInit();
    controller.init();
  }

  @override
  void onDispose() {
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
            FlatButton(
              child: Text('Skip >'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
