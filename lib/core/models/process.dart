// lib/core/models/process.dart
// Modelo de dados para um processo de licitação, alinhado com a estrutura do Firestore.
import 'package:cloud_firestore/cloud_firestore.dart'; // Importar para usar Timestamp

class Process {
  final String id; // ID do documento no Firestore
  final String processNumber; // Corresponde a 'processNumber' no Firestore
  final String objectDescription; // Corresponde a 'objectDescription'
  final String sectorId; // Corresponde a 'sectorId'
  final String assessorId; // Corresponde a 'assessorId'
  final String modality; // Corresponde a 'modality'
  final String contractType; // Corresponde a 'contractType'
  final String currentPhase; // Corresponde a 'currentPhase'
  final String status; // Corresponde a 'status'
  final String observations; // Corresponde a 'observations'
  final double estimatedValue; // Corresponde a 'estimatedValue'
  final DateTime openingDate; // Corresponde a 'openingDate'
  final DateTime
  expectedCompletionDate; // Corresponde a 'expectedCompletionDate' (pode ser nulo)
  final DateTime?
  actualCompletionDate; // Corresponde a 'actualCompletionDate' (pode ser nulo)
  final String? delayReason; // Corresponde a 'delayReason' (pode ser nulo)
  final DateTime lastActivityDate; // Corresponde a 'lastActivityDate'
  final List<Map<String, String>> attachments; // Corresponde a 'attachments'
  final bool isRenewable; // Corresponde a 'isRenewable'
  final String? contractId; // Corresponde a 'contractId' (pode ser nulo)

  Process({
    required this.id,
    required this.processNumber,
    required this.objectDescription,
    required this.sectorId,
    required this.assessorId,
    required this.modality,
    required this.contractType,
    required this.currentPhase,
    required this.status,
    required this.observations,
    required this.estimatedValue,
    required this.openingDate,
    required this.expectedCompletionDate,
    this.actualCompletionDate,
    this.delayReason,
    required this.lastActivityDate,
    this.attachments = const [],
    required this.isRenewable,
    this.contractId,
  });

  // Construtor de fábrica para criar um objeto Process a partir de um documento Firestore
  factory Process.fromFirestore(Map<String, dynamic> data, String id) {
    return Process(
      id: id,
      processNumber: data['processNumber'] ?? '',
      objectDescription: data['objectDescription'] ?? '',
      sectorId: data['sectorId'] ?? '',
      assessorId: data['assessorId'] ?? '',
      modality: data['modality'] ?? '',
      contractType: data['contractType'] ?? '',
      currentPhase: data['currentPhase'] ?? '',
      status: data['status'] ?? '',
      observations: data['observations'] ?? '',
      estimatedValue: (data['estimatedValue'] as num?)?.toDouble() ?? 0.0,
      openingDate: (data['openingDate'] as Timestamp).toDate(),
      expectedCompletionDate: (data['expectedCompletionDate'] as Timestamp)
          .toDate(),
      actualCompletionDate: data['actualCompletionDate'] != null
          ? (data['actualCompletionDate'] as Timestamp).toDate()
          : null,
      delayReason: data['delayReason'],
      lastActivityDate: (data['lastActivityDate'] as Timestamp).toDate(),
      attachments: List<Map<String, String>>.from(data['attachments'] ?? []),
      isRenewable: data['isRenewable'] ?? false,
      contractId: data['contractId'],
    );
  }

  // Converte o objeto Process para um mapa para salvar no Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'processNumber': processNumber,
      'objectDescription': objectDescription,
      'sectorId': sectorId,
      'assessorId': assessorId,
      'modality': modality,
      'contractType': contractType,
      'currentPhase': currentPhase,
      'status': status,
      'observations': observations,
      'estimatedValue': estimatedValue,
      'openingDate': Timestamp.fromDate(openingDate),
      'expectedCompletionDate': Timestamp.fromDate(expectedCompletionDate),
      'actualCompletionDate': actualCompletionDate != null
          ? Timestamp.fromDate(actualCompletionDate!)
          : null,
      'delayReason': delayReason,
      'lastActivityDate': Timestamp.fromDate(lastActivityDate),
      'attachments': attachments,
      'isRenewable': isRenewable,
      'contractId': contractId,
    };
  }
}
