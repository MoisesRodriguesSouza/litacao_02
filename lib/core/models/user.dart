// lib/core/models/user.dart
// Modelo de dados para o utilizador da aplicação.
// Adicionado import para Timestamp para consistência.
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String displayName;
  final String role; // Ex: 'admin', 'gestor', 'assessor'
  final String sectorId; // ID do setor ao qual o utilizador pertence
  final DateTime createdAt;
  final DateTime lastLogin;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
    required this.sectorId,
    required this.createdAt,
    required this.lastLogin,
  });

  // Construtor de fábrica para criar um objeto User a partir de um mapa (ex: Firestore)
  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(
      id: id, // O ID do documento Firestore é passado como 'id'
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      role: data['role'] ?? 'assessor', // Role padrão como 'assessor'
      sectorId: data['sectorId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLogin: (data['lastLogin'] as Timestamp).toDate(),
    );
  }

  // Converte o objeto User para um mapa para salvar no Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'role': role,
      'sectorId': sectorId,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
    };
  }
}
