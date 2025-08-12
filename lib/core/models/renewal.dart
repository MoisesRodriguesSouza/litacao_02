// Placeholder: lib/core/models/renewal.dart
// Modelo de dados para renovações/aditivos (simplificado para UI)
// import 'package:cloud_firestore/cloud_firestore.dart'; // Comentado
// import 'package:json_annotation/json_annotation.dart'; // Comentado
// part 'renewal.g.dart'; // Comentado

// @JsonSerializable() // Comentado
class Renewal {
  final String? id;
  final String processId;
  final String type;
  final DateTime dataInicio; // Alterado de Timestamp para DateTime
  final DateTime dataTermino; // Alterado de Timestamp para DateTime
  final double? valorAditivo;
  final String? observation;
  final bool isCompliantLaw14133;

  Renewal({
    this.id,
    required this.processId,
    required this.type,
    required this.dataInicio,
    required this.dataTermino,
    this.valorAditivo,
    this.observation,
    required this.isCompliantLaw14133,
  });

  // Métodos fromJson/toJson adaptados para dados simulados (sem json_annotation)
  factory Renewal.fromJson(Map<String, dynamic> json) {
    return Renewal(
      id: json['id'] as String?,
      processId: json['processId'] as String,
      type: json['type'] as String,
      dataInicio: DateTime.parse(json['dataInicio'] as String),
      dataTermino: DateTime.parse(json['dataTermino'] as String),
      valorAditivo: (json['valorAditivo'] as num?)?.toDouble(),
      observation: json['observation'] as String?,
      isCompliantLaw14133: json['isCompliantLaw14133'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'processId': processId,
      'type': type,
      'dataInicio': dataInicio.toIso8601String(),
      'dataTermino': dataTermino.toIso8601String(),
      'valorAditivo': valorAditivo,
      'observation': observation,
      'isCompliantLaw14133': isCompliantLaw14133,
    };
  }
}
