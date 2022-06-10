import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;

  AuthUser(this.uid);

  @override
  List<Object> get props => [uid];
}

abstract class AuthRepositoryBase {
  Stream<AuthUser?> get onAuthStateChanged;

  Future<AuthUser?> signInWithEmailAndPassword(String email, String password);

  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password);

  Future<AuthUser?> signInWithGoogle();

  Future<AuthUser?> signInWithFacebook();

  Future<AuthUser?> signInAnonymously();

  Future<void> signOut();
}
