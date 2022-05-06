import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_connectivity_tutorial/src/examples/cubit/connection_status_cubit.dart';
import 'package:flutter_connectivity_tutorial/src/examples/getx/connection_status_controller.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';
import 'package:get/get.dart';

class GetXExampleScreen extends StatelessWidget {
  const GetXExampleScreen();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConnectionStatusController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Example'),
      ),
      body: Obx(() {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('The device has access to the Internet:'),
              Text(
                controller.status.value == ConnectionStatus.online
                    ? 'True'
                    : 'False',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        );
      }),
    );
  }
}
