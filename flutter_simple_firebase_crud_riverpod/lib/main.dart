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

// Create a global instance of GetIt that can be user later to
// retrieve our injected instances
final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inject dependencies
  await injectDependencies();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Helper function to inject dependencies
Future<void> injectDependencies() async {
  // Inject the data source.
  getIt.registerLazySingleton(() => FirebaseDataSource());

  // Inject the Repositories. Note that the type is the abstract class
  // and the injected instance is the implementation.
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
  getIt.registerLazySingleton<MyUserRepository>(() => MyUserRepositoryImp());
}
