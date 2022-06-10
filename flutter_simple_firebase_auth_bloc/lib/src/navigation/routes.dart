import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_auth/src/ui/email_create_screen.dart';
import 'package:flutter_simple_firebase_auth/src/ui/email_signin_screen.dart';
import 'package:flutter_simple_firebase_auth/src/ui/home_screen.dart';
import 'package:flutter_simple_firebase_auth/src/ui/intro_screen.dart';
import 'package:flutter_simple_firebase_auth/src/ui/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';
  static const home = '/home';

  static Route routes(RouteSettings routeSettings) {
    print('Route name: ${routeSettings.name}');

    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case intro:
        return _buildRoute(IntroScreen.create);
      case home:
        return _buildRoute(HomeScreen.create);
      case createAccount:
        return _buildRoute(EmailCreate.create);
      case signInEmail:
        return _buildRoute(EmailSignIn.create);
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) => MaterialPageRoute(builder: (context) => build(context));
}
