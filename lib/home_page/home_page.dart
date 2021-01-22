import 'package:flutter/material.dart';
import 'package:younghappychallenge/core/base/base_page.dart';
import 'package:younghappychallenge/home_page/home.dart';
import 'package:younghappychallenge/home_page/model/input_is_new_user.dart';

// ignore: must_be_immutable
class HomePage extends BasePage<HomeController> {
  static const routeName = '/home';

  HomePage(BuildContext context, HomeController initController)
      : super(context, initController);

  InputIsNewUser _isNewUser;

  @override
  void onStateInit() {
    super.onStateInit();
    controller.init();

    final InputIsNewUser args = ModalRoute.of(context).settings.arguments;
    if (_isNewUser == null) _isNewUser = args;
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
        child: StreamBuilder(
          stream: controller.builderNameStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
