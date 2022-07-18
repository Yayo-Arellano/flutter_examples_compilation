import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<UserUID?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().asyncMap((user) => user?.uid);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
