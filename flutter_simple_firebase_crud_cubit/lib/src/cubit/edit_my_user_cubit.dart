import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_firebase_crud_cubit/main.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/model/my_user.dart';
import 'package:flutter_simple_firebase_crud_cubit/src/repository/my_user_repository.dart';

// Extends Cubit and will emit states of type EditMyUserState
class EditMyUserCubit extends Cubit<EditMyUserState> {
  // Get the injected MyUserRepository
  final MyUserRepository _userRepository = getIt();

  // When we are editing an existing myUser _toEdit won't be null
  MyUser? _toEdit;

  EditMyUserCubit(this._toEdit) : super(const EditMyUserState());

  // This function will be called from the presentation layer
  // when an image is selected
  void setImage(File? imageFile) async {
    emit(state.copyWith(pickedImage: imageFile));
  }

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveMyUser(
    String name,
    String lastName,
    int age,
  ) async {
    emit(state.copyWith(isLoading: true));

    // If we are editing we use the existing id otherwise create a new one.
    // Note: that we are using the current time to generate the id, this is
    // not a good practice but for this example is good enough
    final uid = _toEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    _toEdit = MyUser(
        id: uid,
        name: name,
        lastName: lastName,
        age: age,
        image: _toEdit?.image);

    await _userRepository.saveMyUser(_toEdit!, state.pickedImage);
    emit(state.copyWith(isDone: true));
  }

  // This function will be called from the presentation layer
  // when we want to delete the user
  Future<void> deleteMyUser() async {
    emit(state.copyWith(isLoading: true));
    if (_toEdit != null) {
      await _userRepository.deleteMyUser(_toEdit!);
    }
    emit(state.copyWith(isDone: true));
  }
}

// Class that will holds the state of this Cubit
// Extending Equatable will help us to compare if two instances
// are the same without override == and hashCode
class EditMyUserState extends Equatable {
  final File? pickedImage;
  final bool isLoading;

  // In the presentation layer we will check the value of isDone.
  // When is true we will navigate to the previous page
  final bool isDone;

  const EditMyUserState({
    this.pickedImage,
    this.isLoading = false,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [pickedImage?.path, isLoading, isDone];

  // Helper function that updates some properties of this object,
  // and returns a new updated instance of EditMyUserState
  EditMyUserState copyWith({
    File? pickedImage,
    bool? isLoading,
    bool? isDone,
  }) {
    return EditMyUserState(
      pickedImage: pickedImage ?? this.pickedImage,
      isLoading: isLoading ?? this.isLoading,
      isDone: isDone ?? this.isDone,
    );
  }
}
