import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_getx/src/controller/auth_controller.dart';
import 'package:flutter_simple_firebase_crud_getx/src/controller/home_controller.dart';
import 'package:flutter_simple_firebase_crud_getx/src/navigation/routes.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/widgets/custom_image.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        actions: [
          IconButton(
            key: const Key('Logout'),
            onPressed: () {
              Get.find<AuthController>().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(Routes.editUser);
        },
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: homeController.myUsers.value.length,
          itemBuilder: (context, index) {
            final myUser = homeController.myUsers.value.elementAt(index);
            return Card(
              child: ListTile(
                onTap: () {
                  Get.toNamed(Routes.editUser, arguments: myUser);
                },
                leading: SizedBox(
                  height: 45,
                  width: 45,
                  child: CustomImage(imageUrl: myUser.image),
                ),
                title: Text('${myUser.name} ${myUser.lastName}'),
                subtitle: Text('Age: ${myUser.age}'),
              ),
            );
          },
        );
      }),
    );
  }
}
