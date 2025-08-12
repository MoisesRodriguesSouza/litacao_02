// Placeholder: lib/core/services/firestore_service.dart
// Este serviço agora retorna apenas dados simulados
class FirestoreService {
  // Exemplo de como obter dados (simulado)
  Stream<List<Map<String, dynamic>>> getProcesses() {
    print('Simulando obtenção de processos.');
    // Retorna uma lista de processos simulados
    return Stream.value([
      {
        'id': 'proc_001',
        'codigo_processo': 'PL-2024-001',
        'fase_atual': 'ETP',
        'status': 'Em Andamento',
        'objeto_licitacao': 'Aquisição de Material de Escritório',
        'data_abertura': DateTime.now()
            .subtract(Duration(days: 30))
            .toIso8601String(),
        'data_prevista_conclusao': DateTime.now()
            .add(Duration(days: 60))
            .toIso8601String(),
        'assessor_tecnico_id': 'simulated_user_id',
      },
      {
        'id': 'proc_002',
        'codigo_processo': 'DL-2024-005',
        'fase_atual': 'Homologação',
        'status': 'Finalizado',
        'objeto_licitacao': 'Contratação de Serviço de Limpeza',
        'data_abertura': DateTime.now()
            .subtract(Duration(days: 90))
            .toIso8601String(),
        'data_prevista_conclusao': DateTime.now()
            .subtract(Duration(days: 10))
            .toIso8601String(),
        'assessor_tecnico_id': 'simulated_user_id',
      },
      {
        'id': 'proc_003',
        'codigo_processo': 'PE-2024-010',
        'fase_atual': 'Parado',
        'status': 'Parado',
        'objeto_licitacao': 'Reforma de Edifício Público',
        'data_abertura': DateTime.now()
            .subtract(Duration(days: 120))
            .toIso8601String(),
        'data_prevista_conclusao': DateTime.now()
            .add(Duration(days: 30))
            .toIso8601String(),
        'assessor_tecnico_id': 'simulated_user_id',
      },
    ]);
  }

  // Exemplo de como adicionar dados (simulado)
  Future<void> addProcess(Map<String, dynamic> data) async {
    print('Simulando adição de processo: $data');
    await Future.delayed(const Duration(seconds: 1)); // Simula uma requisição
  }
}
