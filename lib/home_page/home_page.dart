import 'package:flutter/material.dart';
import 'package:younghappychallenge/core/base/base_page.dart';
import 'package:younghappychallenge/home_page/home.dart';

class HomePage extends BasePage<HomeController> {
  static const routeName = '/home';

  HomePage(BuildContext context, HomeController initController)
      : super(context, initController);

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
