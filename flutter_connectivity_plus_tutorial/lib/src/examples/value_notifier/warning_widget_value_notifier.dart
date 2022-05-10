import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/examples/value_notifier/connection_status_value_notifier.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';

class WarningWidgetValueNotifier extends StatelessWidget {
  const WarningWidgetValueNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectionStatusValueNotifier(),
      builder: (context, ConnectionStatus status, child) {
        return Visibility(
          visible: status != ConnectionStatus.online,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Colors.brown,
            child: Row(
              children: [
                const Icon(Icons.wifi_off),
                const SizedBox(width: 8),
                const Text('No internet connection.'),
              ],
            ),
          ),
        );
      },
    );
  }
}
