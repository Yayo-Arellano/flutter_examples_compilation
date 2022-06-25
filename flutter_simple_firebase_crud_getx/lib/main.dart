import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_getx/src/app.dart';
import 'package:flutter_simple_firebase_crud_getx/src/data_source/firebase_data_source.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/auth_repository.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/implementation/auth_repository.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/implementation/my_user_repository.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/my_user_repository.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await injectDependencies();

  runApp(MyApp());
}

Future<void> injectDependencies() async {
  // Data sources
  getIt.registerLazySingleton(() => FirebaseDataSource());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
  getIt.registerLazySingleton<MyUserRepository>(() => MyUserRepositoryImp());
}
