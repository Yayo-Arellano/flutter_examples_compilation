import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_connectivity_tutorial/src/examples/cubit/connection_status_cubit.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';

class CubitExampleScreen extends StatelessWidget {
  const CubitExampleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit Example'),
      ),
      body: BlocProvider(
        create: (context) => ConnectionStatusCubit(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('The device has access to the Internet:'),
              BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                builder: (_, state) {
                  return Text(
                    state == ConnectionStatus.online ? 'True' : 'False',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
