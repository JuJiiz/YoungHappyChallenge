import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:younghappychallenge/address/address_repository.dart';
import 'package:younghappychallenge/authentication/authentication_repository.dart';
import 'package:younghappychallenge/core/constants.dart';
import 'package:younghappychallenge/home_page/home.dart';
import 'package:younghappychallenge/login_page/login.dart';
import 'package:younghappychallenge/register_page/register.dart';
import 'package:younghappychallenge/splash_screen/splash_screen.dart';
import 'package:younghappychallenge/testing_repository.dart';
import 'package:younghappychallenge/user/user_repository.dart';

class ChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreenPage.routeName,
      routes: <String, WidgetBuilder>{
        SplashScreenPage.routeName: (context) => SplashScreenPage(
              context,
              SplashScreenController(
                Provider.of<AuthenticationRepository>(context),
                Provider.of<UserRepository>(context),
              ),
            ),
        HomePage.routeName: (context) => HomePage(
              context,
              HomeController(Provider.of<TestingRepository>(context)),
            ),
        LoginPage.routeName: (context) => LoginPage(
              context,
              LoginController(Provider.of<AuthenticationRepository>(context)),
            ),
        RegisterPage.routeName: (context) => RegisterPage(
              context,
              RegisterController(
                Provider.of<AddressRepository>(context),
                Provider.of<UserRepository>(context),
              ),
            ),
      },
    );
  }
}
