// Dart imports:
import 'dart:convert';

class UserModel {
  String userId;
  String name;
  String email;
  String password;
  String role;
  int staffOrderDoneCount;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.staffOrderDoneCount=0,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'staffOrderDoneCount': staffOrderDoneCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? '',
      staffOrderDoneCount: map['staffOrderDoneCount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
