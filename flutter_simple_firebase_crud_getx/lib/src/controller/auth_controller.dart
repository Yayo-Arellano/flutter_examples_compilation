import 'dart:async';

import 'package:flutter_simple_firebase_crud_getx/main.dart';
import 'package:flutter_simple_firebase_crud_getx/src/navigation/routes.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/auth_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = getIt();
  StreamSubscription? _authSubscription;

  final Rx<AuthState> authState = Rx(AuthState.initial);

  @override
  void onInit() async {
    // Just for testing. Allows the splash screen to be shown a few seconds
    await Future.delayed(const Duration(seconds: 3));
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
    super.onInit();
  }

  void _authStateChanged(String? userUID) {
    if (userUID == null) {
      authState.value = AuthState.signedOut;
      Get.offAllNamed(Routes.intro);
    } else {
      authState.value = AuthState.signedIn;
      Get.offAllNamed(Routes.home);
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _authStateChanged(null);
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }
}

enum AuthState {
  initial,
  signedOut,
  signedIn,
}
