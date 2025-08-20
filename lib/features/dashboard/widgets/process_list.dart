// lib/features/dashboard/widgets/process_list.dart
// Widget para exibir uma lista de processos reais do Firestore.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/process.dart'; // Importa o modelo de Process

class ProcessList extends StatelessWidget {
  final List<Process> processes; // Lista de processos reais

  const ProcessList({super.key, required this.processes});

  @override
  Widget build(BuildContext context) {
    if (processes.isEmpty) {
      return const Center(child: Text('Nenhum processo encontrado.'));
    }

    return ListView.builder(
      itemCount: processes.length,
      itemBuilder: (context, index) {
        final process = processes[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: Icon(
              Icons.description,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(process.objectDescription),
            subtitle: Text(
              'Nº: ${process.processNumber} - Status: ${process.status} - Setor: ${process.sectorId}',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navegar para a tela de detalhes do processo
              context.go('/process-detail/${process.id}');
            },
          ),
        );
      },
    );
  }
}
