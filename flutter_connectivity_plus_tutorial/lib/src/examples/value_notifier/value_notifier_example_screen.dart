import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/examples/value_notifier/connection_status_value_notifier.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';

class ValueNotifierExampleScreen extends StatelessWidget {
  const ValueNotifierExampleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Value notifier Example'),
      ),
      body: ValueListenableBuilder(
          valueListenable: ConnectionStatusValueNotifier(),
          builder: (context, ConnectionStatus status, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('The device has access to the Internet:'),
                  Text(
                    status == ConnectionStatus.online ? 'True' : 'False',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
