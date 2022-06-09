import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_simple_firebase_auth/src/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends AuthRepositoryBase {
  final _firebaseAuth = FirebaseAuth.instance;

  AuthUser? _userFromFirebase(User? user) => user == null ? null : AuthUser(user.uid);

  @override
  Stream<AuthUser?> get onAuthStateChanged => _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInWithFacebook() async {
    final result = await FacebookAuth.instance.login();

    final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

    final authResult = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInAnonymously() async {
    final user = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
