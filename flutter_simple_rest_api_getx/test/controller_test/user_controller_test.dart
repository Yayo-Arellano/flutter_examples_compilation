
import 'package:flutter_simple_rest_api_getx/controllers/user_controller.dart';
import 'package:flutter_simple_rest_api_getx/models/user.dart';
import 'package:flutter_simple_rest_api_getx/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_controller_test.mocks.dart';

@GenerateMocks([UserRepository, User])
void main() {
  late MockUserRepository mockRepo;

  setUp(() {
    Get.reset();
    mockRepo = MockUserRepository();

    Get.put<UserRepository>(mockRepo);
  });

  test('Controller will load empty list when initialized', () async {
    when(mockRepo.getAllUsers()).thenAnswer((_) async => []);
    final controller = Get.put(UserController());

    expect(controller.users.length, 0);
    verify(mockRepo.getAllUsers()).called(1);
  });

  test('Controller will load one user', () async {
    when(mockRepo.getAllUsers()).thenAnswer((_) async => [
      const User('Yayo', 'Arellano', 'Taipei', 'https://..'),
    ]);
    final controller = Get.put(UserController());
    await Future.delayed(const Duration(milliseconds: 10));

    expect(controller.users.length, 1);
  });

  test('Controller will load one user: test 2', () async {
    when(mockRepo.getAllUsers())
        .thenAnswer((_) async => [MockUser(), MockUser(), MockUser()]);
    final controller = Get.put(UserController());
    await Future.delayed(const Duration(milliseconds: 10));

    expect(controller.users.length, 3);
  });

  test('Get new user will add a new user correctly', () async {
    when(mockRepo.getAllUsers()).thenAnswer((_) async => [MockUser()]);
    when(mockRepo.getNewUser()).thenAnswer((_) async => MockUser());

    final controller = Get.put(UserController());
    await Future.delayed(const Duration(milliseconds: 10));

    // Before adding
    expect(controller.users.length, 1);

    // Adding
    await controller.getUser();
    expect(controller.users.length, 2);
  });

  test('Delete users works correctly', () async {
    final userToDelete = MockUser();
    when(mockRepo.getAllUsers())
        .thenAnswer((_) async => [MockUser(), MockUser(), userToDelete]);
    when(mockRepo.deleteUser(any)).thenAnswer((_) async => true);

    final controller = Get.put(UserController());
    await Future.delayed(const Duration(milliseconds: 10));

    // Before delete
    expect(controller.users.length, 3);
    expect(controller.users, contains(userToDelete));

    // deleting
    await controller.deleteUser(userToDelete);
    expect(controller.users.length, 2);
    expect(controller.users, isNot(contains(userToDelete)));
  });
}























