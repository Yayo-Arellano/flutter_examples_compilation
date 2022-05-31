import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_simple_firebase_crud_cubit/main.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/cubit/home_screen_cubit.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/repository/my_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const _myUser1 = MyUser(id: '111', name: 'Yayo', lastName: 'Arellano', age: 28);
const _myUser2 = MyUser(id: '222', name: 'Juan', lastName: 'Perez', age: 35);

class MockMyUserRepo extends Mock implements MyUserRepository {}

void main() {
  late MockMyUserRepo mockRepo;
  setUp(() async {
    await getIt.reset();
    mockRepo = MockMyUserRepo();
    getIt.registerSingleton<MyUserRepository>(mockRepo);
  });

  blocTest<HomeScreenCubit, HomeScreenState>(
    'Two users will be emitted correctly',
    build: () {
      when(() => mockRepo.getMyUsers()).thenAnswer((_) {
        return Stream.fromIterable([
          [_myUser1, _myUser2]
        ]);
      });
      return HomeScreenCubit();
    },
    act: (cubit) => cubit.init(),
    expect: () => [
      const HomeScreenState(
        isLoading: false,
        myUsers: [_myUser1, _myUser2],
      )
    ],
  );
}
