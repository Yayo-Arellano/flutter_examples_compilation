import 'dart:io';

import 'package:flutter_simple_firebase_crud_getx/src/model/my_user.dart';

abstract class MyUserRepository {
  Stream<Iterable<MyUser>> getMyUsers();

  Future<void> saveMyUser(MyUser myUser, File? image);

  Future<void> deleteMyUser(MyUser myUser);
}
