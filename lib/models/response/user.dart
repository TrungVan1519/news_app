import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;

  const User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.username,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        username: json['username'] as String?,
        password: json['password'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'username': username,
        'password': password,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, email, phone, username, password];
}
