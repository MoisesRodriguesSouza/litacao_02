// Placeholder: lib/features/dashboard/widgets/process_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acao_licita/core/services/firestore_service.dart';
import 'package:acao_licita/core/models/process.dart'; // Importa o modelo de processo
import 'package:go_router/go_router.dart';

// Provedor para o serviço Firestore
final firestoreServiceProvider = Provider((ref) => FirestoreService());

class ProcessList extends ConsumerWidget {
  const ProcessList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreService = ref.read(firestoreServiceProvider);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: firestoreService.getProcesses(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar processos: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum processo encontrado.'));
        }

        final processesData = snapshot.data!;

        return ListView.builder(
          itemCount: processesData.length,
          itemBuilder: (context, index) {
            final processMap = processesData[index];
            final process = Process.fromJson(
              processMap,
            ); // Converte o mapa para o objeto Process

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(process.codigoProcesso),
                subtitle: Text(
                  'Fase: ${process.faseAtual} - Status: ${process.status}',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  context.go(
                    '/process-detail/${process.id}',
                  ); // Navegar para a página de detalhes do processo
                },
              ),
            );
          },
        );
      },
    );
  }
}
