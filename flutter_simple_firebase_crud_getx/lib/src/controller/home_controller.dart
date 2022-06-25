import 'dart:async';

import 'package:flutter_simple_firebase_crud_getx/main.dart';
import 'package:flutter_simple_firebase_crud_getx/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/my_user_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final MyUserRepository _userRepository = getIt();
  StreamSubscription? _myUsersSubscription;

  Rx<bool> isLoading = Rx(true);
  Rx<Iterable<MyUser>> myUsers = Rx([]);

  @override
  void onInit() {
    super.onInit();
    _myUsersSubscription = _userRepository.getMyUsers().listen(myUserListen);
  }

  void myUserListen(Iterable<MyUser> myUsers) async {
    isLoading.value = false;
    this.myUsers.value = myUsers;
  }

  @override
  void onClose() {
    _myUsersSubscription?.cancel();
    return super.onClose();
  }
}
