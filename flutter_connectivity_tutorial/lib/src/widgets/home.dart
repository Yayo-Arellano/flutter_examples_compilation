import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/navigation/routes.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose an option'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.providerExample),
              child: Text('Provider Example (ChangeNotifier)'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.blocExample),
              child: Text('Flutter Bloc Example (Cubit)'),
            ),
          ],
        ),
      ),
    );
  }
}
