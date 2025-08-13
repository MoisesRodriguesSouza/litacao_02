// lib/features/reports/screens/reports_page.dart
// Tela para visualização de relatórios.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/custom_app_bar.dart'; // Importa o CustomAppBar
import '../widgets/report_filters.dart'; // Importa o widget de filtros

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Relatórios de Licitações'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtros de Relatório',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const ReportFilters(), // Widget para os filtros de relatório
            const SizedBox(height: 24),
            Text(
              'Resultados do Relatório',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  'Conteúdo do relatório será exibido aqui.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            // TODO: Adicionar gráficos e tabelas de resultados aqui
          ],
        ),
      ),
    );
  }
}
