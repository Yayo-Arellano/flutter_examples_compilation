import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/navigation/routes.dart';

void main() async {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter connectivity example',
      onGenerateRoute: Routes.routes,
    );
  }
}
