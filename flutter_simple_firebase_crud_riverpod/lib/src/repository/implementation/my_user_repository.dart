import 'dart:io';

import 'package:flutter_simple_firebase_crud_riverpod/main.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/data_source/firebase_data_source.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/my_user_repository.dart';

class MyUserRepositoryImp extends MyUserRepository {
  final FirebaseDataSource _fDataSource = getIt();

  @override
  Stream<Iterable<MyUser>> getMyUsers() {
    return _fDataSource.getMyUsers();
  }

  @override
  Future<void> saveMyUser(MyUser myUser, File? image) {
    return _fDataSource.saveMyUser(myUser, image);
  }

  @override
  Future<void> deleteMyUser(MyUser myUser) {
    return _fDataSource.deleteMyUser(myUser);
  }
}
