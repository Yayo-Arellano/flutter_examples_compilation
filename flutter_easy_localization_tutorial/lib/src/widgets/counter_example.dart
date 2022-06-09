import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CounterExample extends StatefulWidget {
  @override
  _CounterExampleState createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  int _counter = 0;

  void _updateCounter(int times) {
    if (_counter + times < 0) return;
    setState(() => _counter += times);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('counter'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('counter_description'.tr()),
            Text(
              'press_times'.plural(_counter),
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => _updateCounter(1),
              child: Text('increase'.tr()),
            ),
            ElevatedButton(
              onPressed: () => _updateCounter(-1),
              child: Text('decrease'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
