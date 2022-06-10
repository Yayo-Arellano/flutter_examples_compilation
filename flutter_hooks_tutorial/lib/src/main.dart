import 'package:flutter/material.dart';
import 'package:flutter_hooks_tutorial/src/navigation/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks Tutorial',
      onGenerateRoute: Routes.routes,
    );
  }
}

