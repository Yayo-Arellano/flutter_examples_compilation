import 'dart:io';

import 'package:flutter_simple_firebase_auth/model/user.dart';

abstract class MyUserRepository {
  Future<MyUser?> getMyUser();

  Future<void> saveMyUser(MyUser user, File? image);
}
