import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_riverpod/main.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/my_user_repository.dart';

class HomeScreenNotifier extends ChangeNotifier {
  final MyUserRepository _userRepository = getIt();
  StreamSubscription? _myUsersSubscription;

  var isLoading = true;
  Iterable<MyUser> myUsers = [];

  Future<void> init() async {
    _myUsersSubscription = _userRepository.getMyUsers().listen(myUserListen);
  }

  void myUserListen(Iterable<MyUser> myUsers) async {
    isLoading = false;
    this.myUsers = myUsers;
    notifyListeners();
  }

  @override
  void dispose() {
    _myUsersSubscription?.cancel();
    return super.dispose();
  }
}
