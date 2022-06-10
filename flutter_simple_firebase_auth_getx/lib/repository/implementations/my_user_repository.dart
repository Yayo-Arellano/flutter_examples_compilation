import 'dart:io';

import 'package:flutter_simple_firebase_auth/model/user.dart';
import 'package:flutter_simple_firebase_auth/provider/firebase_provider.dart';
import 'package:flutter_simple_firebase_auth/repository/my_user_repository.dart';

class MyUserRepositoryImp extends MyUserRepository {
  final provider = FirebaseProvider();

  @override
  Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<void> saveMyUser(MyUser user, File? image) => provider.saveMyUser(user, image);
}
