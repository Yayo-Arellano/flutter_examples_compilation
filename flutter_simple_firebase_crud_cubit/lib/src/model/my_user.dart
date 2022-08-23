import 'package:equatable/equatable.dart';

// Extending Equatable will help us to compare two instances of
// MyUser class, and we will not have to override == and hashCode.
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

  // When comparing two instances of MyUser class we want to check
  // that all the properties are the same, then we can say that
  // the two instances are equals
  @override
  List<Object?> get props => [id, name, lastName, age, image];

  // Helper function to convert this MyUser to a Map
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age,
      'image': image,
    };
  }

  // Helper function to convert a Map to an instance of MyUser
  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        lastName = data['lastName'] as String,
        age = data['age'] as int,
        image = data['image'] as String?;

  // Helper function that updates some properties of this instance,
  // and returns a new updated instance of MyUser
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
