import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/navigation/routes.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';

// Usually this will be initialized one time at the start of the app
final internetChecker = CheckInternetConnection();

void main() async {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter connectivity example',
      onGenerateRoute: Routes.routes,
    );
  }
}
