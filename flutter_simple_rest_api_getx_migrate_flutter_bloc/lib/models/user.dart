import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String lastName;
  final String city;
  final String? thumbnail;

  const User(
      this.name,
      this.lastName,
      this.city,
      this.thumbnail,
      );

  User.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        lastName = map['lastName'],
        city = map['city'],
        thumbnail = map['thumbnail'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'name': name,
      'lastName': lastName,
      'city': city,
      'thumbnail': thumbnail,
    };
  }

  @override
  List<Object?> get props => [name, lastName, city, thumbnail];
}
