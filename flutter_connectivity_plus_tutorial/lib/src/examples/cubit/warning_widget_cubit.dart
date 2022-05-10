import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_connectivity_tutorial/src/examples/cubit/connection_status_cubit.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';

class WarningWidgetCubit extends StatelessWidget {
  const WarningWidgetCubit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionStatusCubit(),
      child: BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
          builder: (context, status) {
        return Visibility(
          visible: status != ConnectionStatus.online,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Colors.green,
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
