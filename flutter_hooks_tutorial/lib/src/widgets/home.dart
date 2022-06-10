import 'package:flutter/material.dart';
import 'package:flutter_hooks_tutorial/src/navigation/routes.dart';

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
              onPressed: () => Navigator.pushNamed(context, Routes.counter),
              child: Text('Counter app'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.createAccount),
              child: Text('Form'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.scroll),
              child: Text('Scroll'),
            ),
          ],
        ),
      ),
    );
  }
}
