// Dart imports:
import 'dart:convert';

class RoleModel {
  String userId;
  String role;
  RoleModel({
    required this.userId,
    required this.role,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'role': role,
    };
  }

  factory RoleModel.fromMap(Map<String, dynamic> map) {
    return RoleModel(
      userId: map['userId'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleModel.fromJson(String source) => RoleModel.fromMap(json.decode(source));
}
