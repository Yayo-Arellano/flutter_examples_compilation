import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_simple_firebase_crud_cubit/main.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/repository/my_user_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final MyUserRepository _userRepository = getIt();
  StreamSubscription? _myUsersSubscription;

  HomeCubit() : super(const HomeState());

  Future<void> init() async {
    _myUsersSubscription = _userRepository.getMyUsers().listen(myUserListen);
  }

  void myUserListen(Iterable<MyUser> myUsers) async {
    emit(HomeState(
      isLoading: false,
      myUsers: myUsers,
    ));
  }

  @override
  Future<void> close() {
    _myUsersSubscription?.cancel();
    return super.close();
  }
}

class HomeState extends Equatable {
  final bool isLoading;
  final Iterable<MyUser> myUsers;

  const HomeState({
    this.isLoading = true,
    this.myUsers = const [],
  });

  @override
  List<Object?> get props => [isLoading, myUsers];
}
