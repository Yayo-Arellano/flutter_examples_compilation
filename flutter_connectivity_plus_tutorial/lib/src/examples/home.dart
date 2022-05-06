import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/navigation/routes.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose an option'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.cubitExample),
              child: const Text('Cubit Example'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.getXExample),
              child: const Text('GetX Example'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.valueNotifierExample),
              child: const Text('Value Notifier Example'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.changeNotifierExample),
              child: const Text('Change Notifier Example'),
            ),
          ],
        ),
      ),
    );
  }
}
