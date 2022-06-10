import 'dart:io';

import 'package:flutter_simple_firebase_auth/src/model/user.dart';
import 'package:flutter_simple_firebase_auth/src/provider/firebase_provider.dart';
import 'package:flutter_simple_firebase_auth/src/repository/my_user_repository.dart';

class MyUserRepository extends MyUserRepositoryBase {
  final provider = FirebaseProvider();

  @override
  Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<void> saveMyUser(MyUser user, File? image) => provider.saveMyUser(user, image);
}
