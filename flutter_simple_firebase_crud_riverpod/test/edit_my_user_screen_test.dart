import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_firebase_crud_riverpod/main.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/repository/my_user_repository.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/ui/edit_my_user_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const _myUser1 = MyUser(id: '111', name: 'Yayo', lastName: 'Arellano', age: 28);

class _MockMyUser extends Mock implements MyUser {}
class _MockMyUserRepo extends Mock implements MyUserRepository {}

void main() {
  late _MockMyUserRepo mockRepo;

  setUp(() async {
    await getIt.reset();
    registerFallbackValue(_MockMyUser());
    mockRepo = _MockMyUserRepo();
    getIt.registerSingleton<MyUserRepository>(mockRepo);
  });

  Widget getMaterialApp({MyUser? arguments}) {
    return ProviderScope(child: MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: RouteSettings(arguments: arguments),
          builder: (context) {
            return const EditMyUserScreen();
          },
        );
      },
    ));
  }

  testWidgets('Saving user will call repository successfully',
      (WidgetTester tester) async {
    when(() => mockRepo.saveMyUser(any(), null)).thenAnswer((_) async {});

    await tester.pumpWidget(getMaterialApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('Name')), 'Yayo');
    await tester.enterText(find.byKey(const Key('Last Name')), 'Are');
    await tester.enterText(find.byKey(const Key('Age')), '25');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pump(const Duration(seconds: 3));

    verify(() => mockRepo.saveMyUser(any(), null)).called(1);
  });

  testWidgets('Updating user will call repository successfully',
      (WidgetTester tester) async {
    when(() => mockRepo.saveMyUser(any(), null)).thenAnswer((_) async {});

    await tester.pumpWidget(getMaterialApp(arguments: _myUser1));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('Name')), 'Hola');
    await tester.enterText(find.byKey(const Key('Last Name')), 'Mundo');
    await tester.enterText(find.byKey(const Key('Age')), '10');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pump(const Duration(seconds: 3));

    final updatedUser =
        _myUser1.copyWith(name: 'Hola', lastName: 'Mundo', age: 10);
    verify(() => mockRepo.saveMyUser(updatedUser, null)).called(1);
  });

  testWidgets('When is a new user delete button is not visible',
      (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('Delete')), findsNothing);
  });

  testWidgets('When is an editing user delete button is visible',
      (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialApp(arguments: _myUser1));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('Delete')), findsOneWidget);
  });

  testWidgets('Deleting an editing user will call repository successfully',
      (WidgetTester tester) async {
    when(() => mockRepo.deleteMyUser(any())).thenAnswer((_) async {});

    await tester.pumpWidget(getMaterialApp(arguments: _myUser1));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('Delete')));
    await tester.pump();

    verify(() => mockRepo.deleteMyUser(_myUser1)).called(1);
  });
}
