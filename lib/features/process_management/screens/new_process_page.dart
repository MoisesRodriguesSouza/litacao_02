// lib/features/process_management/screens/new_process_page.dart
// Tela para cadastrar um novo processo de licitação.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/custom_app_bar.dart'; // Importa o CustomAppBar
import '../widgets/process_form.dart'; // Importa o widget do formulário

class NewProcessPage extends ConsumerWidget {
  const NewProcessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Novo Processo de Licitação'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ProcessForm(), // Usa o widget ProcessForm para o conteúdo
      ),
    );
  }
}
