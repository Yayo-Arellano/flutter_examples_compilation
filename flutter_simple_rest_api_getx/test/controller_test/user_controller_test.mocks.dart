// Mocks generated by Mockito 5.0.16 from annotations
// in flutter_simple_rest_api_getx/test/controller_test/user_controller_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_simple_rest_api_getx/models/user.dart' as _i2;
import 'package:flutter_simple_rest_api_getx/repository/user_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUser_0 extends _i1.Fake implements _i2.User {}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.User> getNewUser() =>
      (super.noSuchMethod(Invocation.method(#getNewUser, []),
              returnValue: Future<_i2.User>.value(_FakeUser_0()))
          as _i4.Future<_i2.User>);
  @override
  _i4.Future<List<_i2.User>> getAllUsers() =>
      (super.noSuchMethod(Invocation.method(#getAllUsers, []),
              returnValue: Future<List<_i2.User>>.value(<_i2.User>[]))
          as _i4.Future<List<_i2.User>>);
  @override
  _i4.Future<bool> deleteUser(_i2.User? toDelete) =>
      (super.noSuchMethod(Invocation.method(#deleteUser, [toDelete]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [User].
///
/// See the documentation for Mockito's code generation for more information.
class MockUser extends _i1.Mock implements _i2.User {
  MockUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  String get lastName =>
      (super.noSuchMethod(Invocation.getter(#lastName), returnValue: '')
          as String);
  @override
  String get city =>
      (super.noSuchMethod(Invocation.getter(#city), returnValue: '') as String);
  @override
  Map<String, dynamic> toMapForDb() =>
      (super.noSuchMethod(Invocation.method(#toMapForDb, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  String toString() => super.toString();
}
