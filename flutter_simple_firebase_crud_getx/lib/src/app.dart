import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_getx/src/controller/auth_controller.dart';
import 'package:flutter_simple_firebase_crud_getx/src/navigation/routes.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: authController,
      builder: (_) {
        return const GetMaterialApp(
          title: 'Authentication Flow',
          onGenerateRoute: Routes.routes,
        );
      },
    );
  }
}
