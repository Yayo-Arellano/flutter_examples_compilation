import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_riverpod/main.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/my_user_repository.dart';

class EditMyUserNotifier extends ChangeNotifier {
  final MyUserRepository _userRepository = getIt();

  MyUser? _toEdit;

  File? pickedImage;
  bool isLoading = false;
  bool isDone = false;

  EditMyUserNotifier(this._toEdit);

  void setImage(File? imageFile) async {
    pickedImage = imageFile;
    notifyListeners();
  }

  Future<void> saveMyUser(
    String name,
    String lastName,
    int age,
  ) async {
    isLoading = true;
    notifyListeners();

    final uid = _toEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    _toEdit = MyUser(
        id: uid,
        name: name,
        lastName: lastName,
        age: age,
        image: _toEdit?.image);

    // Just for testing we add a 3 seconds delay: This allows to see the loading in the home page
    await Future.delayed(const Duration(seconds: 3));
    await _userRepository.saveMyUser(_toEdit!, pickedImage);
    isDone = true;
    notifyListeners();
  }

  Future<void> deleteMyUser() async {
    isLoading = true;
    notifyListeners();

    if (_toEdit != null) {
      await _userRepository.deleteMyUser(_toEdit!);
    }
    isDone = true;
    notifyListeners();
  }
}
