import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_auth/app.dart';
import 'package:flutter_simple_firebase_auth/repository/auth_repository.dart';
import 'package:flutter_simple_firebase_auth/repository/implementations/auth_repository.dart';
import 'package:flutter_simple_firebase_auth/repository/implementations/my_user_repository.dart';
import 'package:flutter_simple_firebase_auth/repository/my_user_repository.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put<AuthRepository>(AuthRepositoryImp());
  Get.put<MyUserRepository>(MyUserRepositoryImp());

  runApp(MyApp());
}
