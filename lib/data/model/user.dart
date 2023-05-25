import 'dart:convert';

class User {
  String email;
  String password;
  String jwt;

  User({
    required this.email,
    required this.password,
    required this.jwt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'jwt': jwt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
      jwt: map['jwt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(email: $email, password: $password, jwt: $jwt)';
}
