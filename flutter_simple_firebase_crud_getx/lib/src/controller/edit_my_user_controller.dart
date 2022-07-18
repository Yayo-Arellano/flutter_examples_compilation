import 'dart:async';
import 'dart:io';

import 'package:flutter_simple_firebase_crud_getx/main.dart';
import 'package:flutter_simple_firebase_crud_getx/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/my_user_repository.dart';
import 'package:get/get.dart';

class EditMyUserController extends GetxController {
  // Get the injected MyUserRepository
  final MyUserRepository _userRepository = getIt();

  // Reactive variables that will hold the state of this GetxController
  Rx<File?> pickedImage = Rx(null);
  Rx<bool> isLoading = Rx(false);

  // When we are editing _toEdit won't be null
  MyUser? _toEdit;

  EditMyUserController(this._toEdit);

  // This function will be called from the presentation layer
  // when an image is selected
  void setImage(File? imageFile) async {
    pickedImage.value = imageFile;
  }

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveMyUser(
    String name,
    String lastName,
    int age,
  ) async {
    isLoading.value = true;

    // If we are editing we use the existing id otherwise create a new one.
    // Note that we are using the current time to generate the id, this is
    // not a good practice but for this example is good enough
    final uid = _toEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    _toEdit = MyUser(
        id: uid,
        name: name,
        lastName: lastName,
        age: age,
        image: _toEdit?.image);

    await _userRepository.saveMyUser(_toEdit!, pickedImage.value);
    isLoading.value = false;

    // Navigate to the previous screen after the user is saved.
    // Note: This is a GetX bad practice, navigation should be done in
    // the presentation layer
    Get.back();
  }

  // This function will be called from the presentation layer
  // when we want to delete the user
  Future<void> deleteMyUser() async {
    isLoading.value = true;
    if (_toEdit != null) {
      await _userRepository.deleteMyUser(_toEdit!);
    }
    isLoading.value = false;

    // Navigate to previous screen after the user is deleted.
    // Note: This is a GetX bad practice, navigation should be done in
    // the presentation layer
    Get.back();
  }
}
