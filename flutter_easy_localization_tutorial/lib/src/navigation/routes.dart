import 'package:flutter/material.dart';
import 'package:flutter_easy_localization/src/widgets/counter_example.dart';
import 'package:flutter_easy_localization/src/widgets/form_example.dart';
import 'package:flutter_easy_localization/src/widgets/home.dart';

class Routes {
  static const root = '/';
  static const counterExample = '/counterExample';
  static const formExample = '/formExample';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case root:
        return _buildRoute(HomeWidget());
      case counterExample:
        return _buildRoute(CounterExample());
      case formExample:
        return _buildRoute(FormExample());
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Widget widget) => MaterialPageRoute(builder: (_) => widget);
}
