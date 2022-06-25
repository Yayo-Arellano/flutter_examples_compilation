import 'dart:async';
import 'dart:io';

import 'package:flutter_simple_firebase_crud_getx/main.dart';
import 'package:flutter_simple_firebase_crud_getx/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/my_user_repository.dart';
import 'package:get/get.dart';

class EditMyUserController extends GetxController {
  final MyUserRepository _userRepository = getIt();

  Rx<File?> pickedImage = Rx(null);
  Rx<bool> isLoading = Rx(false);

  MyUser? _toEdit;

  EditMyUserController(this._toEdit);

  void setImage(File? imageFile) async {
    pickedImage.value = imageFile;
  }

  Future<void> saveMyUser(
    String name,
    String lastName,
    int age,
  ) async {
    isLoading.value = true;
    final uid = _toEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    _toEdit = MyUser(
        id: uid,
        name: name,
        lastName: lastName,
        age: age,
        image: _toEdit?.image);

    // Just for testing we add a 3 seconds delay: This allows to see the loading in the home page
    await Future.delayed(const Duration(seconds: 3));
    await _userRepository.saveMyUser(_toEdit!, pickedImage.value);
    isLoading.value = false;
    Get.back();
  }

  Future<void> deleteMyUser() async {
    isLoading.value = true;
    if (_toEdit != null) {
      await _userRepository.deleteMyUser(_toEdit!);
    }
    isLoading.value = false;
    Get.back();
  }
}
