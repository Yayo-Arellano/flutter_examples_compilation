import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/app.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/data_source/firebase_data_source.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/auth_repository.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/implementation/auth_repository.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/implementation/my_user_repository.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/my_user_repository.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await injectDependencies();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> injectDependencies() async {
  // Data sources
  getIt.registerLazySingleton(() => FirebaseDataSource());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
  getIt.registerLazySingleton<MyUserRepository>(() => MyUserRepositoryImp());
}
