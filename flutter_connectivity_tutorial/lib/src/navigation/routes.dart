import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/widgets/bloc_example.dart';
import 'package:flutter_connectivity_tutorial/src/widgets/home.dart';
import 'package:flutter_connectivity_tutorial/src/widgets/provider_example.dart';

class Routes {
  static const root = '/';
  static const providerExample = '/providerExample';
  static const blocExample = '/blocExample';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case root:
        return _buildRoute(HomeWidget());
      case providerExample:
        return _buildRoute(ProviderExample.create());
      case blocExample:
        return _buildRoute(BlocExample.create());
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Widget widget) => MaterialPageRoute(builder: (_) => widget);
}
