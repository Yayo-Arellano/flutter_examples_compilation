import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_firebase_crud_riverpod/main.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository = getIt();
  StreamSubscription? _authSubscription;

  AuthNotifier() : super(AuthState.initial);

  Future<void> init() async {
    // Just for testing. Allows the splash screen to be shown a few seconds
    await Future.delayed(const Duration(seconds: 3));
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  void _authStateChanged(String? userUID) {
    userUID == null ? state = AuthState.signedOut : state = AuthState.signedIn;
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = AuthState.signedOut;
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    return super.dispose();
  }
}

enum AuthState {
  initial,
  signedOut,
  signedIn,
}
