// lib/features/process_management/widgets/phase_timeline.dart
// Widget para exibir uma linha do tempo das fases de um processo.
import 'package:flutter/material.dart';

class PhaseTimeline extends StatelessWidget {
  final List<Map<String, String>>
  phases; // Lista de fases com nome, data e status

  const PhaseTimeline({super.key, required this.phases});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Para que o ListView ocupe apenas o espaço necessário
      physics:
          const NeverScrollableScrollPhysics(), // Desabilita o scroll próprio
      itemCount: phases.length,
      itemBuilder: (context, index) {
        final phase = phases[index];
        final isLast = index == phases.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                // Ícone da fase
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getStatusColor(phase['status'] ?? ''),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getStatusIcon(phase['status'] ?? ''),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                // Linha vertical de conexão (exceto para a última fase)
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50, // Altura da linha entre as fases
                    color: Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      phase['name'] ?? 'Fase Desconhecida',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      phase['date'] ?? 'Data Desconhecida',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      'Status: ${phase['status'] ?? ''}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getStatusColor(phase['status'] ?? ''),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ), // Espaçamento entre os itens da linha do tempo
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Função auxiliar para obter a cor com base no status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Concluído':
        return Colors.green;
      case 'Em Andamento':
        return Colors.blue;
      case 'Pendente':
        return Colors.orange;
      case 'Atrasado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Função auxiliar para obter o ícone com base no status
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Concluído':
        return Icons.check_circle;
      case 'Em Andamento':
        return Icons.hourglass_empty;
      case 'Pendente':
        return Icons.pending;
      case 'Atrasado':
        return Icons.error;
      default:
        return Icons.circle;
    }
  }
}
