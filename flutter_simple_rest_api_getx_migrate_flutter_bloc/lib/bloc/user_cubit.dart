import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_rest_api_getx/main.dart';
import 'package:flutter_simple_rest_api_getx/models/user.dart';
import 'package:flutter_simple_rest_api_getx/repository/user_repository.dart';

class UserCubit extends Cubit<UserCubitState> {
  List<User> _users = [];

  UserCubit() : super(UserCubitState(users: const []));

  Future<void> loadInitialData() async {
    _users = await getIt<UserRepository>().getAllUsers();
    emit(UserCubitState(users: _users));
  }

  Future<void> getUser() async {
    if (state.isLoading) return;
    emit(UserCubitState(users: _users, isLoading: true));
    final newUser = await getIt<UserRepository>().getNewUser();
    _users.insert(0, newUser);
    emit(UserCubitState(users: _users, isLoading: false));
  }

  Future<void> deleteUser(User toDelete) async {
    _users.remove(toDelete);
    getIt<UserRepository>().deleteUser(toDelete);
    emit(UserCubitState(users: _users));
  }
}

class UserCubitState extends Equatable {
  final bool isLoading;
  final List<User> users;

  UserCubitState({
    required List users,
    this.isLoading = false,
  }) : users = List.from(users);

  @override
  List<Object?> get props => [isLoading, users];
}
