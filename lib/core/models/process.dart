// Placeholder: lib/core/models/process.dart
// Modelo de dados para processos (simplificado para UI)
// import 'package:json_annotation/json_annotation.dart'; // Comentado
// part 'process.g.dart'; // Comentado

// @JsonSerializable() // Comentado
class Process {
  final String? id;
  final String codigoProcesso;
  // Alterado de Timestamp para DateTime para testes de UI
  final DateTime dataAbertura;
  final DateTime dataPrevistaConclusao;
  final DateTime? dataRealConclusao;
  final String faseAtual;
  final String status;
  final String? objetoLicitacao;
  final String? assessorTecnicoId;

  Process({
    this.id,
    required this.codigoProcesso,
    required this.dataAbertura,
    required this.dataPrevistaConclusao,
    this.dataRealConclusao,
    required this.faseAtual,
    required this.status,
    this.objetoLicitacao,
    this.assessorTecnicoId,
  });

  // Métodos fromJson/toJson adaptados para dados simulados (sem json_annotation)
  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      id: json['id'] as String?,
      codigoProcesso: json['codigo_processo'] as String,
      dataAbertura: DateTime.parse(json['data_abertura'] as String),
      dataPrevistaConclusao: DateTime.parse(
        json['data_prevista_conclusao'] as String,
      ),
      dataRealConclusao: (json['data_real_conclusao'] as String?) != null
          ? DateTime.parse(json['data_real_conclusao'] as String)
          : null,
      faseAtual: json['fase_atual'] as String,
      status: json['status'] as String,
      objetoLicitacao: json['objeto_licitacao'] as String?,
      assessorTecnicoId: json['assessor_tecnico_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo_processo': codigoProcesso,
      'data_abertura': dataAbertura.toIso8601String(),
      'data_prevista_conclusao': dataPrevistaConclusao.toIso8601String(),
      'data_real_conclusao': dataRealConclusao?.toIso8601String(),
      'fase_atual': faseAtual,
      'status': status,
      'objeto_licitacao': objetoLicitacao,
      'assessor_tecnico_id': assessorTecnicoId,
    };
  }

  // Método copyWith simplificado (manter ou remover conforme necessidade da UI)
  Process copyWith({
    String? id,
    String? codigoProcesso,
    DateTime? dataAbertura,
    DateTime? dataPrevistaConclusao,
    DateTime? dataRealConclusao,
    String? faseAtual,
    String? status,
    String? objetoLicitacao,
    String? assessorTecnicoId,
  }) {
    return Process(
      id: id ?? this.id,
      codigoProcesso: codigoProcesso ?? this.codigoProcesso,
      dataAbertura: dataAbertura ?? this.dataAbertura,
      dataPrevistaConclusao:
          dataPrevistaConclusao ?? this.dataPrevistaConclusao,
      dataRealConclusao: dataRealConclusao ?? this.dataRealConclusao,
      faseAtual: faseAtual ?? this.faseAtual,
      status: status ?? this.status,
      objetoLicitacao: objetoLicitacao ?? this.objetoLicitacao,
      assessorTecnicoId: assessorTecnicoId ?? this.assessorTecnicoId,
    );
  }
}
