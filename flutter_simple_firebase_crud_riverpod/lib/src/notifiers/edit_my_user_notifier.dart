import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_riverpod/main.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/my_user_repository.dart';

class EditMyUserNotifier extends ChangeNotifier {
  // Get the injected MyUserRepository
  final MyUserRepository _userRepository = getIt();

  // Variables that will hold the state of this ChangeNotifier
  File? pickedImage;
  bool isLoading = false;

  // In the presentation layer we will check the value of isDone.
  // When is true we will navigate to the previous page
  bool isDone = false;

  // When we are editing _toEdit won't be null
  MyUser? _toEdit;

  EditMyUserNotifier(this._toEdit);

  // This function will be called from the presentation layer
  // when an image is selected
  void setImage(File? imageFile) async {
    pickedImage = imageFile;
    notifyListeners();
  }

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveMyUser(
    String name,
    String lastName,
    int age,
  ) async {
    isLoading = true;
    notifyListeners();

    // If we are editing, we use the existing id. Otherwise, create a new one.
    final uid = _toEdit?.id ?? _userRepository.newId();
    _toEdit = MyUser(
        id: uid,
        name: name,
        lastName: lastName,
        age: age,
        image: _toEdit?.image);

    await _userRepository.saveMyUser(_toEdit!, pickedImage);
    isDone = true;
    notifyListeners();
  }

  // This function will be called from the presentation layer
  // when we want to delete the user
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
