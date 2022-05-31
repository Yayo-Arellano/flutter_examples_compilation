import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/model/my_user.dart';
import 'package:path/path.dart' as path;

class FirebaseDataSource {
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  FirebaseStorage get storage => FirebaseStorage.instance;

  Stream<Iterable<MyUser>> getMyUsers() {
    return firestore
        .collection('user/${currentUser.uid}/myUsers')
        .snapshots()
        .map((it) => it.docs.map((e) => MyUser.fromFirebaseMap(e.data())));
  }

  Future<void> saveMyUser(MyUser myUser, File? image) async {
    final ref = firestore.doc('user/${currentUser.uid}/myUsers/${myUser.id}');
    if (image != null) {
      // Delete current image if exists
      if (myUser.image != null) {
        await storage.refFromURL(myUser.image!).delete();
      }
      final imagePath = '${currentUser.uid}/myUsersImages/${path.basename(image.path)}';
      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      myUser = myUser.copyWith(image: url);
    }
    await ref.set(myUser.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<void> deleteMyUser(MyUser myUser) async {
    final ref = firestore.doc('user/${currentUser.uid}/myUsers/${myUser.id}');
    // Delete current image if exists
    if (myUser.image != null) {
      await storage.refFromURL(myUser.image!).delete();
    }
    await ref.delete();
  }
}
