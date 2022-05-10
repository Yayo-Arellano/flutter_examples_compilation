import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/examples/change_notifier/warning_widget_change_notifier.dart';
import 'package:flutter_connectivity_tutorial/src/examples/fake_user_list.dart';

class ChangeNotifierExampleScreen extends StatelessWidget {
  const ChangeNotifierExampleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Example'),
      ),
      body: Column(
        children: <Widget>[
          const WarningWidgetChangeNotifier(),
          const FakeUserList(),
        ],
      ),
    );
  }
}
