import 'package:flutter/material.dart';
import 'package:flutter_connectivity_tutorial/src/examples/getx/connection_status_controller.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';
import 'package:get/get.dart';

class WarningWidgetGetX extends StatelessWidget {
  const WarningWidgetGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConnectionStatusController());
    return Obx(() {
      return Visibility(
        visible: controller.status.value != ConnectionStatus.online,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 60,
          color: Colors.purple,
          child: Row(
            children: [
              const Icon(Icons.wifi_off),
              const SizedBox(width: 8),
              const Text('No internet connection.'),
            ],
          ),
        ),
      );
    });
  }
}
