// lib/core/models/sector.dart
// Modelo de dados para um setor demandante.
import 'package:cloud_firestore/cloud_firestore.dart';

class Sector {
  final String id; // ID do documento no Firestore
  final String name; // Nome do setor
  final String code; // Código ou sigla do setor
  final bool active; // Indica se o setor está ativo

  Sector({
    required this.id,
    required this.name,
    required this.code,
    required this.active,
  });

  // Construtor de fábrica para criar um objeto Sector a partir de um documento Firestore
  factory Sector.fromFirestore(Map<String, dynamic> data, String id) {
    return Sector(
      id: id,
      name: data['name'] ?? '',
      code: data['code'] ?? '',
      active: data['active'] ?? true, // Por padrão, ativo se não especificado
    );
  }

  // Converte o objeto Sector para um mapa para salvar no Firestore
  Map<String, dynamic> toFirestore() {
    return {'name': name, 'code': code, 'active': active};
  }
}
