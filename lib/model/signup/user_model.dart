import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUser {
  final String name;

  final String email;
  final String password;

  CreateUser({
    required this.name,
    required this.email,
    required this.password,
  });

  factory CreateUser.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;

    return CreateUser(
      name: data['name'],
      email: data['email'],
      password: data['password'],

      //  idImage: data['idImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
