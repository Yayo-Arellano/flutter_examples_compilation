import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_firebase_auth/src/model/user.dart';
import 'package:flutter_simple_firebase_auth/src/repository/my_user_repository.dart';

class MyUserCubit extends Cubit<MyUserState> {
  final MyUserRepositoryBase _userRepository;

  File? _pickedImage;
  late MyUser _user;

  MyUserCubit(this._userRepository) : super(MyUserLoadingState());

  void setImage(File? imageFile) async {
    _pickedImage = imageFile;
    emit(MyUserReadyState(_user, _pickedImage));
  }

  Future<void> getMyUser() async {
    emit(MyUserLoadingState());
    _user = (await _userRepository.getMyUser()) ?? const MyUser('', '', '', 0);
    emit(MyUserReadyState(_user, _pickedImage));
  }

  Future<void> saveMyUser(
    String uid,
    String name,
    String lastName,
    int age,
  ) async {
    _user = MyUser(uid, name, lastName, age, image: _user.image);
    emit(MyUserReadyState(_user, _pickedImage, isSaving: true));
    // Just for testing we add a 3 seconds delay: This allows to see the loading in the home page
    await Future.delayed(const Duration(seconds: 3));
    await _userRepository.saveMyUser(_user, _pickedImage);
    emit(MyUserReadyState(_user, _pickedImage));
  }
}

abstract class MyUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyUserLoadingState extends MyUserState {}

class MyUserReadyState extends MyUserState {
  final MyUser user;
  final File? pickedImage;
  final bool isSaving;

  MyUserReadyState(this.user, this.pickedImage, {this.isSaving = false});

  @override
  List<Object?> get props => [user, pickedImage?.path, isSaving];
}
