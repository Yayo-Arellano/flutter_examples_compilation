import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_simple_firebase_crud_getx/main.dart';
import 'package:flutter_simple_firebase_crud_getx/src/app.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/auth_repository.dart';
import 'package:flutter_simple_firebase_crud_getx/src/repository/my_user_repository.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/home_screen.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/intro_screen.dart';
import 'package:flutter_simple_firebase_crud_getx/src/ui/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepo extends Mock implements AuthRepository {}

class _MockMyUserRepo extends Mock implements MyUserRepository {}

Stream<String> get loggedUserStream => Stream.fromIterable(['someUserID']);

void main() {
  late _MockAuthRepo mockRepo;
  late _MockMyUserRepo mockUserRepo;

  setUp(() async {
    await getIt.reset();
    Get.reset();

    mockRepo = _MockAuthRepo();
    mockUserRepo = _MockMyUserRepo();

    when(() => mockUserRepo.getMyUsers())
        .thenAnswer((_) => Stream.fromIterable([]));

    getIt.registerSingleton<AuthRepository>(mockRepo);
    getIt.registerSingleton<MyUserRepository>(mockUserRepo);
  });

  testWidgets(
      'Intro screen will be shown after splash when the user is not logged in',
      (WidgetTester tester) async {
    final stream = Stream.fromIterable([null]);
    when(() => mockRepo.onAuthStateChanged).thenAnswer((_) => stream);

    await tester.pumpWidget(MyApp());
    await tester.pump();
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(IntroScreen), findsOneWidget);
  });

  testWidgets(
      'Home screen will be shown after splash when the user is logged in',
      (WidgetTester tester) async {
    when(() => mockRepo.onAuthStateChanged).thenAnswer((_) => loggedUserStream);

    await tester.pumpWidget(MyApp());
    await tester.pump();
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Pressing logout will return to the IntroScreen',
      (WidgetTester tester) async {
    when(() => mockRepo.onAuthStateChanged).thenAnswer((_) => loggedUserStream);
    when(() => mockRepo.signOut()).thenAnswer((_) async {});

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);

    await tester.tap(find.byKey(const Key('Logout')));
    await tester.pumpAndSettle();

    expect(find.byType(IntroScreen), findsOneWidget);
  });
}
