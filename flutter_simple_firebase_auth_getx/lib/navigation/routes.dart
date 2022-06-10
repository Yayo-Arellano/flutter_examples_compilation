import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_auth/ui/email_create_screen.dart';
import 'package:flutter_simple_firebase_auth/ui/email_signin_screen.dart';
import 'package:flutter_simple_firebase_auth/ui/home_screen.dart';
import 'package:flutter_simple_firebase_auth/ui/intro_screen.dart';
import 'package:flutter_simple_firebase_auth/ui/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';
  static const home = '/home';

  static Route routes(RouteSettings settings) {

    switch (settings.name) {
      case splash:
        return _buildRoute(settings, page: const SplashScreen());
      case intro:
        return _buildRoute(settings, page: const IntroScreen());
      case home:
        return _buildRoute(settings, page: const HomeScreen());
      case createAccount:
        return _buildRoute(settings, page: EmailCreate());
      case signInEmail:
        return _buildRoute(settings, page: EmailSignIn());
      default:
        throw Exception('Route does not exists');
    }
  }

  static GetPageRoute _buildRoute(RouteSettings settings, {required Widget page}) =>
      GetPageRoute(settings: settings, page: () => page);
}
