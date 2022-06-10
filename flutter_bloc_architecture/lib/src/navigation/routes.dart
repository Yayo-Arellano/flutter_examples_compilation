import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/src/ui/news_detail_screen.dart';
import 'package:flutter_bloc_architecture/src/ui/news_screen.dart';

/// Esta clase se encargara de administrar las rutas
class Routes {
  static const topNews = '/';
  static const newsDetails = '/details';

  static Route routes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case topNews:
        return MaterialPageRoute(builder: (context) => NewsScreen.create(context));
      case newsDetails:
        return MaterialPageRoute(builder: (_) => NewsDetailScreen.create(args!));
    }
    throw Exception('This route does not exists');
  }
}
