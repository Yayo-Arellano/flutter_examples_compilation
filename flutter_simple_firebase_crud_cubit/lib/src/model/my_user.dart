import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final int age;

  final String? image;

  const MyUser({
    required this.id,
    required this.name,
    required this.lastName,
    required this.age,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, lastName, age, image];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age,
      'image': image,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        lastName = data['lastName'] as String,
        age = data['age'] as int,
        image = data['image'] as String?;

  MyUser copyWith({
    String? id,
    String? name,
    String? lastName,
    int? age,
    String? image,
  }) {
    return MyUser(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      image: image ?? this.image,
    );
  }
}
