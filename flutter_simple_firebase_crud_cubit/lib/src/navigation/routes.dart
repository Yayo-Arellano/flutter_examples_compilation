import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/edit_my_user_screen.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/home_screen.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/intro_screen.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const editUser = '/editUser';

  static Route routes(RouteSettings settings) {
    // Helper nested function.
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(
        builder: (_) => widget,
        settings: settings,
      );
    }

    switch (settings.name) {
      case splash:
        return buildRoute(const SplashScreen());
      case intro:
        return buildRoute(const IntroScreen());
      case home:
        return buildRoute(const HomeScreen());
      case editUser:
        return buildRoute(const EditMyUserScreen());
      default:
        throw Exception('Route does not exists');
    }
  }
}
