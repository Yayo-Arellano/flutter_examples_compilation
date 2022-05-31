typedef UserUID = String;

abstract class AuthRepository {
  Stream<UserUID?> get onAuthStateChanged;

  Future<void> signOut();
}
