import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_simple_firebase_crud_getx/src/model/my_user.dart';

class FirebaseDataSource {
  // Helper function to get the currently authenticated user
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  // Generates and returns a new firestore id
  String newId() {
    return firestore.collection('tmp').doc().id;
  }

  // Read all documents from MyUser collection from the authenticated user
  Stream<Iterable<MyUser>> getMyUsers() {
    return firestore
        .collection('user/${currentUser.uid}/myUsers')
        .snapshots()
        .map((it) => it.docs.map((e) => MyUser.fromFirebaseMap(e.data())));
  }

  // Creates or updates a document in myUser collection. If image is not null
  // it will create or update the image in Firebase Storage
  Future<void> saveMyUser(MyUser myUser, File? image) async {
    final ref = firestore.doc('user/${currentUser.uid}/myUsers/${myUser.id}');
    if (image != null) {
      // Delete current image if exists
      if (myUser.image != null) {
        await storage.refFromURL(myUser.image!).delete();
      }

      final fileName = image.uri.pathSegments.last;
      final imagePath = '${currentUser.uid}/myUsersImages/$fileName';

      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      myUser = myUser.copyWith(image: url);
    }
    await ref.set(myUser.toFirebaseMap(), SetOptions(merge: true));
  }

  // Deletes the MyUser document. Also will delete the
  // image from Firebase Storage
  Future<void> deleteMyUser(MyUser myUser) async {
    final ref = firestore.doc('user/${currentUser.uid}/myUsers/${myUser.id}');

    // Delete current image if exists
    if (myUser.image != null) {
      await storage.refFromURL(myUser.image!).delete();
    }
    await ref.delete();
  }
}
