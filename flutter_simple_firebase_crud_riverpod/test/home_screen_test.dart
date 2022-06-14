import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_firebase_crud_riverpod/main.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/my_user_repository.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/ui/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const _myUser1 = MyUser(id: '111', name: 'Yayo', lastName: 'Arellano', age: 28);
const _myUser2 = MyUser(id: '222', name: 'Gera', lastName: 'Doe', age: 25);

class _MockMyUserRepo extends Mock implements MyUserRepository {}

void main() {
  late _MockMyUserRepo mockRepo;

  setUp(() async {
    await getIt.reset();
    mockRepo = _MockMyUserRepo();
    getIt.registerSingleton<MyUserRepository>(mockRepo);
  });

  Widget getMaterialApp() {
    return const ProviderScope(
        child: MaterialApp(
      home: HomeScreen(),
    ));
  }

  testWidgets('Empty list when repository returns 0 users',
      (WidgetTester tester) async {
    when(() => mockRepo.getMyUsers()).thenAnswer((_) {
      return Stream.fromIterable([]);
    });

    await tester.pumpWidget(getMaterialApp());
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNothing);
  });

  testWidgets('Two items in the  list when repository returns 2 users',
      (WidgetTester tester) async {
    when(() => mockRepo.getMyUsers()).thenAnswer((_) {
      return Stream.fromIterable([
        [_myUser1, _myUser2]
      ]);
    });

    await tester.pumpWidget(getMaterialApp());
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNWidgets(2));
  });
}
