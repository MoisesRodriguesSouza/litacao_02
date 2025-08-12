// Placeholder: lib/core/models/user.dart
// Modelo de dados para usuários (simplificado para UI)
// import 'package:json_annotation/json_annotation.dart'; // Comentado
// part 'user.g.dart'; // Comentado

// @JsonSerializable() // Comentado
class AppUser {
  final String uid;
  final String email;
  final String? displayName; // Pode ser nulo se não definido
  final String? role; // Pode ser nulo
  final String? setorId; // Pode ser nulo

  AppUser({
    required this.uid,
    required this.email,
    this.displayName,
    this.role,
    this.setorId,
  });

  // Métodos fromJson/toJson adaptados para dados simulados (sem json_annotation)
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      role: json['role'] as String?,
      setorId: json['setorId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role,
      'setorId': setorId,
    };
  }
}
