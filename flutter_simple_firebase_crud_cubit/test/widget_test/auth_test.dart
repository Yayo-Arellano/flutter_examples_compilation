import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_firebase_crud_cubit/main.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/app.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/cubit/auth_cubit.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/repository/auth_repository.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/repository/my_user_repository.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/home_screen.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/intro_screen.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/ui/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepo extends Mock implements AuthRepository {}

class _MockMyUserRepo extends Mock implements MyUserRepository {}

Stream<String> get loggedUserStream => Stream.fromIterable(['someUserID']);

void main() {
  late _MockAuthRepo mockRepo;
  late _MockMyUserRepo mockUserRepo;

  setUp(() async {
    await getIt.reset();

    mockRepo = _MockAuthRepo();
    mockUserRepo = _MockMyUserRepo();

    when(() => mockUserRepo.getMyUsers())
        .thenAnswer((_) => Stream.fromIterable([]));

    getIt.registerSingleton<AuthRepository>(mockRepo);
    getIt.registerSingleton<MyUserRepository>(mockUserRepo);
  });

  Widget getMyApp() {
    return BlocProvider(
      create: (_) => AuthCubit()..init(),
      child: const MyApp(),
    );
  }

  testWidgets(
      'Intro screen will be shown after splash when the user is not logged in',
      (WidgetTester tester) async {
    final stream = Stream.fromIterable([null]);
    when(() => mockRepo.onAuthStateChanged).thenAnswer((_) => stream);

    await tester.pumpWidget(getMyApp());
    await tester.pump();
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(IntroScreen), findsOneWidget);
  });

  testWidgets(
      'Home screen will be shown after splash when the user is logged in',
      (WidgetTester tester) async {
    when(() => mockRepo.onAuthStateChanged).thenAnswer((_) => loggedUserStream);

    await tester.pumpWidget(getMyApp());
    await tester.pump();
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Pressing logout will return to the IntroScreen',
      (WidgetTester tester) async {
    when(() => mockRepo.onAuthStateChanged).thenAnswer((_) => loggedUserStream);
    when(() => mockRepo.signOut()).thenAnswer((_) async {});

    await tester.pumpWidget(getMyApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);

    await tester.tap(find.byKey(const Key('Logout')));
    await tester.pumpAndSettle();

    expect(find.byType(IntroScreen), findsOneWidget);
  });
}
