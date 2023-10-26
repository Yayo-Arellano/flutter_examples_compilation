import 'package:flutter/material.dart';
import 'package:flutter_news_app_cubit/src/ui/news_detail_screen.dart';
import 'package:flutter_news_app_cubit/src/ui/news_screen.dart';

class Routes {
  static const newsScreen = '/';
  static const detailsScreen = '/details';

  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }

    return switch (settings.name) {
      newsScreen => buildRoute(const NewsScreen()),
      detailsScreen => buildRoute(const NewsDetailScreen()),
      _ => throw Exception('Route does not exists'),
    };
  }
}
