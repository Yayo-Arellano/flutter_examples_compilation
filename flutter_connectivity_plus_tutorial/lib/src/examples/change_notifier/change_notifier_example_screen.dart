import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/examples/change_notifier/connection_status_change_notifier.dart';
import 'package:flutter_connectivity_tutorial/src/examples/value_notifier/connection_status_value_notifier.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';
import 'package:provider/provider.dart';

class ChangeNotifierExampleScreen extends StatelessWidget {
  const ChangeNotifierExampleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Example'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ConnectionStatusChangeNotifier(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('The device has access to the Internet:'),
              Consumer<ConnectionStatusChangeNotifier>(
                  builder: (context, value, child) {
                return Text(
                  value.status == ConnectionStatus.online ? 'True' : 'False',
                  style: Theme.of(context).textTheme.headline4,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
