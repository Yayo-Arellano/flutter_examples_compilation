import 'package:flutter/material.dart';
import 'package:flutter_hooks_tutorial/src/widgets/counter.dart';
import 'package:flutter_hooks_tutorial/src/widgets/formwidget.dart';
import 'package:flutter_hooks_tutorial/src/widgets/home.dart';
import 'package:flutter_hooks_tutorial/src/widgets/scrollwidget.dart';

class Routes {
  static const root = '/';
  static const counter = '/counter';
  static const createAccount = '/createAccount';
  static const scroll = '/scroll';

  static Route routes(RouteSettings routeSettings) {
    print('Route name: ${routeSettings.name}');

    switch (routeSettings.name) {
      case root:
        return _buildRoute(HomeWidget());
      case counter:
        return _buildRoute(CounterWidget());
      case createAccount:
        return _buildRoute(FormWidget());
      case scroll:
        return _buildRoute(ScrollWidget());
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Widget widget) => MaterialPageRoute(builder: (_) => widget);
}
