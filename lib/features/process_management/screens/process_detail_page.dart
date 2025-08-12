// Placeholder: lib/features/process_management/screens/process_detail_page.dart
import 'package:flutter/material.dart';

class ProcessDetailPage extends StatelessWidget {
  final String processId;
  const ProcessDetailPage({super.key, required this.processId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Processo $processId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detalhes do Processo com ID: $processId',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            const Text(
              'Esta tela será implementada para exibir os detalhes completos do processo.',
            ),
          ],
        ),
      ),
    );
  }
}
