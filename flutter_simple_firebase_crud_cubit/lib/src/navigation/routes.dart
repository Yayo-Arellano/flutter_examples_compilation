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
    MaterialPageRoute _buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }

    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen());
      case intro:
        return _buildRoute(const IntroScreen());
      case home:
        return _buildRoute(const HomeScreen());
      case editUser:
        return _buildRoute(const EditMyUserScreen());
      default:
        throw Exception('Route does not exists');
    }
  }
}
