import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_connectivity_tutorial/src/bloc/connection_status_cubit.dart';

class BlocExample extends StatelessWidget {
  static Widget create() {
    return BlocProvider(
      create: (_) => ConnectionStatusCubit(),
      child: BlocExample(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('The device has access to the Internet:'),
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
    );
  }
}
