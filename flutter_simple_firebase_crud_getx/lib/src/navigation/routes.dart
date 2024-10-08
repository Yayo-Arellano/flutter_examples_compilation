import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/edit_my_user_screen.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/home_screen.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/intro_screen.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const editUser = '/editUser';

  static Route routes(RouteSettings settings) {
    GetPageRoute buildRoute(Widget widget) {
      return GetPageRoute(page: () => widget, settings: settings);
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
