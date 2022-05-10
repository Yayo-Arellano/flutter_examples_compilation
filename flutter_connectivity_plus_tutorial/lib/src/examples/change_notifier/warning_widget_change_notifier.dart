import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/examples/change_notifier/connection_status_change_notifier.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';
import 'package:provider/provider.dart';

class WarningWidgetChangeNotifier extends StatelessWidget {
  const WarningWidgetChangeNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConnectionStatusChangeNotifier(),
      child: Consumer<ConnectionStatusChangeNotifier>(
          builder: (context, value, child) {
        return Visibility(
          visible: value.status != ConnectionStatus.online,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Colors.amberAccent,
            child: Row(
              children: [
                const Icon(Icons.wifi_off),
                const SizedBox(width: 8),
                const Text('No internet connection.'),
              ],
            ),
          ),
        );
      }),
    );
  }
}
