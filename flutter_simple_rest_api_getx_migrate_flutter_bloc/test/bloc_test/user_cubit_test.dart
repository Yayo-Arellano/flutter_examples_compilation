import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_simple_rest_api_getx/bloc/user_cubit.dart';
import 'package:flutter_simple_rest_api_getx/main.dart';
import 'package:flutter_simple_rest_api_getx/models/user.dart';
import 'package:flutter_simple_rest_api_getx/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_cubit_test.mocks.dart';

@GenerateMocks([UserRepository, User])
void main() {
  late MockUserRepository mockRepo;

  setUp(() async {
    await getIt.reset();
    mockRepo = MockUserRepository();

    getIt.registerLazySingleton<UserRepository>(() => mockRepo);
  });

  blocTest<UserCubit, UserCubitState>(
    'Cubit will load empty list when initialized',
    build: () {
      when(mockRepo.getAllUsers()).thenAnswer((_) async => []);
      return UserCubit();
    },
    act: (cubit) async {
      await cubit.loadInitialData();
    },
    verify: (cubit) {
      expect(cubit.state.users.length, 0);
      verify(mockRepo.getAllUsers()).called(1);
    },
  );

  blocTest<UserCubit, UserCubitState>(
    'Cubit will load one user',
    build: () {
      when(mockRepo.getAllUsers()).thenAnswer((_) async => [
            const User('Yayo', 'Arellano', 'Taipei', 'https://..'),
          ]);
      return UserCubit();
    },
    act: (cubit) async {
      await cubit.loadInitialData();
    },
    verify: (cubit) {
      expect(cubit.state.users.length, 1);
    },
  );

  blocTest<UserCubit, UserCubitState>(
    'Cubit will load one user: test 2',
    build: () {
      when(mockRepo.getAllUsers())
          .thenAnswer((_) async => [MockUser(), MockUser(), MockUser()]);
      return UserCubit();
    },
    act: (cubit) async {
      await cubit.loadInitialData();
    },
    verify: (cubit) {
      expect(cubit.state.users.length, 3);
    },
  );

  group('CounterBloc tests', () {
    final mockUser1 = MockUser();
    final mockUser2 = MockUser();
    final mockUsertoDelete = MockUser();

    blocTest<UserCubit, UserCubitState>(
      'Get new user will add a new user correctly',
      build: () {
        when(mockRepo.getAllUsers()).thenAnswer((_) async => [mockUser1]);
        when(mockRepo.getNewUser()).thenAnswer((_) async => mockUser2);
        return UserCubit();
      },
      act: (cubit) async {
        await cubit.loadInitialData();
        await cubit.getUser();
      },
      expect: () {
        return [
          UserCubitState(users: [mockUser1], isLoading: false),
          UserCubitState(users: [mockUser1], isLoading: true),
          UserCubitState(users: [mockUser2, mockUser1], isLoading: false),
        ];
      },
    );

    blocTest<UserCubit, UserCubitState>(
      'Delete users works correctly',
      build: () {
        when(mockRepo.getAllUsers())
            .thenAnswer((_) async => [mockUser1, mockUser2, mockUsertoDelete]);
        when(mockRepo.deleteUser(any)).thenAnswer((_) async => true);
        return UserCubit();
      },
      act: (cubit) async {
        await cubit.loadInitialData();
        await cubit.deleteUser(mockUsertoDelete);
      },
      expect: () {
        return [
          UserCubitState(users: [mockUser1, mockUser2, mockUsertoDelete], isLoading: false),
          UserCubitState(users: [mockUser1, mockUser2], isLoading: false),
        ];
      },
    );
  });
}
