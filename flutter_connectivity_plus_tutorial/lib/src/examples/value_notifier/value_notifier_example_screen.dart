import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/examples/fake_user_list.dart';
import 'package:flutter_connectivity_tutorial/src/examples/value_notifier/warning_widget_value_notifier.dart';

class ValueNotifierExampleScreen extends StatelessWidget {
  const ValueNotifierExampleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Value notifier Example'),
      ),
      body: Column(
        children: <Widget>[
          const WarningWidgetValueNotifier(),
          const FakeUserList(),
        ],
      ),
    );
  }
}
