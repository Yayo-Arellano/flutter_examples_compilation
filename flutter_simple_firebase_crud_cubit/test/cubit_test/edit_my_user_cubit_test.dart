import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_simple_firebase_crud_cubit/main.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/cubit/edit_my_user_cubit.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/repository/my_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const _myUser1 = MyUser(id: '111', name: 'Yayo', lastName: 'Arellano', age: 28);

class MockMyUserRepo extends Mock implements MyUserRepository {}

class MockMyUser extends Mock implements MyUser {}

void main() {
  late MockMyUserRepo mockRepo;
  setUp(() async {
    await getIt.reset();
    registerFallbackValue(MockMyUser());
    mockRepo = MockMyUserRepo();
    getIt.registerSingleton<MyUserRepository>(mockRepo);
  });

  blocTest<EditMyUserCubit, EditMyUserState>(
    'Saving a new user will succeed',
    build: () {
      when(() => mockRepo.saveMyUser(any(), null)).thenAnswer((_) async {});
      when(() => mockRepo.newId()).thenReturn('5555');
      return EditMyUserCubit(null);
    },
    act: (cubit) {
      return cubit.saveMyUser('Gerardo', 'Doe', 25);
    },
    expect: () => [
      const EditMyUserState(
        isLoading: true,
        isDone: false,
      ),
      const EditMyUserState(
        isLoading: true,
        isDone: true,
      )
    ],
    verify: (cubit) {
      const newUser =
          MyUser(id: '5555', name: 'Gerardo', lastName: 'Doe', age: 25);
      verify(() => mockRepo.saveMyUser(newUser, null)).called(1);
    },
  );

  blocTest<EditMyUserCubit, EditMyUserState>(
    'Updating a user will succeed',
    build: () {
      when(() => mockRepo.saveMyUser(any(), null)).thenAnswer((_) async {});
      return EditMyUserCubit(_myUser1);
    },
    act: (cubit) {
      return cubit.saveMyUser('Hola', 'Mundo', 10);
    },
    expect: () => [
      const EditMyUserState(
        isLoading: true,
        isDone: false,
      ),
      const EditMyUserState(
        isLoading: true,
        isDone: true,
      )
    ],
    verify: (cubit) {
      final updatedUser =
          _myUser1.copyWith(name: 'Hola', lastName: 'Mundo', age: 10);
      verify(() => mockRepo.saveMyUser(updatedUser, null)).called(1);
    },
  );

  blocTest<EditMyUserCubit, EditMyUserState>(
    'Trying to delete a new user will not call the repository',
    build: () {
      return EditMyUserCubit(null);
    },
    act: (cubit) {
      return cubit.deleteMyUser();
    },
    expect: () => [
      const EditMyUserState(
        isLoading: true,
        isDone: false,
      ),
      const EditMyUserState(
        isLoading: true,
        isDone: true,
      )
    ],
    verify: (cubit) {
      verifyNever(() => mockRepo.deleteMyUser(any()));
    },
  );

  blocTest<EditMyUserCubit, EditMyUserState>(
    'Trying to delete an existing user will call the repository',
    build: () {
      when(() => mockRepo.deleteMyUser(any())).thenAnswer((_) async {});
      return EditMyUserCubit(_myUser1);
    },
    act: (cubit) {
      return cubit.deleteMyUser();
    },
    expect: () => [
      const EditMyUserState(
        isLoading: true,
        isDone: false,
      ),
      const EditMyUserState(
        isLoading: true,
        isDone: true,
      )
    ],
    verify: (cubit) {
      verify(() => mockRepo.deleteMyUser(_myUser1)).called(1);
    },
  );
}
