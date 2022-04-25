import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/provider/connection_status_model.dart';
import 'package:provider/provider.dart';

class ProviderExample extends StatelessWidget {
  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => ConnectionStatusModel(),
      child: ProviderExample(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('The device has access to the Internet:'),
            Consumer<ConnectionStatusModel>(
              builder: (_, model, __) {
                return Text(
                  model.isOnline ? 'True' : 'False',
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
