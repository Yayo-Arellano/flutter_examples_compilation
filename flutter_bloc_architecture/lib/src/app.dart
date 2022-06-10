import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/src/navigation/routes.dart';

/// Creamos el material APP
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: (settings) => Routes.routes(settings),
    );
  }
}
