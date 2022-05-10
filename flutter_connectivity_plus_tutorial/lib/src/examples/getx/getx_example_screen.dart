import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/examples/fake_user_list.dart';
import 'package:flutter_connectivity_tutorial/src/examples/getx/warning_widget_getx.dart';

class GetXExampleScreen extends StatelessWidget {
  const GetXExampleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Example'),
      ),
      body: Column(
        children: <Widget>[
          const WarningWidgetGetX(),
          const FakeUserList(),
        ],
      ),
    );
  }
}
