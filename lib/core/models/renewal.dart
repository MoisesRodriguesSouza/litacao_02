// lib/core/models/renewal.dart
// Modelo de dados para renovações e aditivos contratuais.
import 'package:cloud_firestore/cloud_firestore.dart'; // Importar para usar Timestamp

class Renewal {
  final String id; // ID do documento no Firestore
  final String processId; // ID do processo de licitação associado
  final String type; // Ex: '1st_renewal', 'Aditivo'
  final DateTime dataInicio;
  final DateTime dataTermino;
  final double? valorAditivo; // Opcional, se for um aditivo de valor
  final String? observation; // Observações sobre a renovação/aditivo
  final bool isCompliantLaw14133; // Indica conformidade com a Lei 14.133/2021

  Renewal({
    required this.id,
    required this.processId,
    required this.type,
    required this.dataInicio,
    required this.dataTermino,
    this.valorAditivo,
    this.observation,
    required this.isCompliantLaw14133,
  });

  // Construtor de fábrica para criar um objeto Renewal a partir de um documento Firestore
  factory Renewal.fromFirestore(Map<String, dynamic> data, String id) {
    return Renewal(
      id: id,
      processId: data['processId'] ?? '',
      type: data['type'] ?? '',
      dataInicio: (data['startDate'] as Timestamp)
          .toDate(), // Usar 'startDate' do Firestore
      dataTermino: (data['endDate'] as Timestamp)
          .toDate(), // Usar 'endDate' do Firestore
      valorAditivo: (data['additionalValue'] as num?)
          ?.toDouble(), // Usar 'additionalValue'
      observation: data['observation'],
      isCompliantLaw14133:
          data['isLaw14133Compliant'] ?? false, // Usar 'isLaw14133Compliant'
    );
  }

  // Converte o objeto Renewal para um mapa para salvar no Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'processId': processId,
      'type': type,
      'startDate': Timestamp.fromDate(dataInicio), // Salvar como 'startDate'
      'endDate': Timestamp.fromDate(dataTermino), // Salvar como 'endDate'
      'additionalValue': valorAditivo,
      'observation': observation,
      'isLaw14133Compliant':
          isCompliantLaw14133, // Salvar como 'isLaw14133Compliant'
    };
  }
}
