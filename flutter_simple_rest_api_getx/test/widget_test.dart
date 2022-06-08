import 'package:flutter/material.dart';
import 'package:flutter_simple_rest_api_getx/main.dart';
import 'package:flutter_simple_rest_api_getx/models/user.dart';
import 'package:flutter_simple_rest_api_getx/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'controller_test/user_controller_test.mocks.dart';

void main() {
  const user1 = User('Yayo', 'Arellano', 'Taiwan', null);
  const user2 = User('Juan', 'Camaney', 'Japon', null);
  const user3 = User('Carlos', 'Caguamas', 'Korea', null);

  late MockUserRepository mockRepo;

  setUp(() {
    Get.reset();
    mockRepo = MockUserRepository();

    when(mockRepo.getAllUsers()).thenAnswer((_) async => [user1, user2]);
    when(mockRepo.getNewUser()).thenAnswer((_) async => user3);
    when(mockRepo.deleteUser(any)).thenAnswer((_) async => true);

    Get.put<UserRepository>(mockRepo);
  });

  testWidgets('Two row of users when app start', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNWidgets(2));
  });

  testWidgets('New user is added correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNWidgets(3));
  });

  testWidgets('User is deleted correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNWidgets(1));
  });
}
