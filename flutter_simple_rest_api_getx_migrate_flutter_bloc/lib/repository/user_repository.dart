import 'package:flutter_simple_rest_api_getx/data_source/db_data_source.dart';
import 'package:flutter_simple_rest_api_getx/data_source/rest_data_source.dart';
import 'package:flutter_simple_rest_api_getx/models/user.dart';

class UserRepository {
  final RestDataSource _restDataSource;
  final DbDataSource _dbDataSource;

  UserRepository(this._restDataSource, this._dbDataSource);

  Future<User> getNewUser() async {
    final name = await _restDataSource.getName();
    final location = await _restDataSource.getLocation();
    final picture = await _restDataSource.getPicture();
    final user = User(name.first, name.last, location.city, picture.thumbnail);
    await _dbDataSource.save(user);
    return user;
  }

  Future<List<User>> getAllUsers() async {
    return _dbDataSource.getAllUsers();
  }

  Future<bool> deleteUser(User toDelete) async {
    final result = await _dbDataSource.delete(toDelete);
    return result == 1;
  }
}















