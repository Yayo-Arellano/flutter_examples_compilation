import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<UserUID?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap((user) => user?.uid);

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}
