import 'package:flutter_simple_rest_api_getx/models/user.dart';
import 'package:flutter_simple_rest_api_getx/repository/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final loading = false.obs;
  final users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    users.value = await Get.find<UserRepository>().getAllUsers();
  }

  Future<void> getUser() async {
    if (loading.isTrue) return;
    loading.value = true;
    final newUser = await Get.find<UserRepository>().getNewUser();
    users.insert(0, newUser);
    loading.value = false;
  }

  Future<void> deleteUser(User toDelete) async {
    users.remove(toDelete);
    Get.find<UserRepository>().deleteUser(toDelete);
  }
}
























