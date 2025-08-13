// lib/features/process_management/widgets/process_form.dart
// Widget de formulário para cadastro e edição de processos de licitação.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProcessForm extends ConsumerStatefulWidget {
  const ProcessForm({super.key});

  @override
  ConsumerState<ProcessForm> createState() => _ProcessFormState();
}

class _ProcessFormState extends ConsumerState<ProcessForm> {
  final _formKey = GlobalKey<FormState>();
  final _numeroProcessoController = TextEditingController();
  final _objetoLicitacaoController = TextEditingController();
  final _setorDemandanteController = TextEditingController();
  // Adicione outros controladores para os campos do processo

  @override
  void dispose() {
    _numeroProcessoController.dispose();
    _objetoLicitacaoController.dispose();
    _setorDemandanteController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implementar lógica para salvar o processo no Firestore
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processo salvo com sucesso! (Simulado)')),
      );
      // Exemplo de como aceder os valores:
      // print('Número do Processo: ${_numeroProcessoController.text}');
      // print('Objeto da Licitação: ${_objetoLicitacaoController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _numeroProcessoController,
            decoration: const InputDecoration(labelText: 'Número do Processo'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o número do processo.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _objetoLicitacaoController,
            decoration: const InputDecoration(labelText: 'Objeto da Licitação'),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o objeto da licitação.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _setorDemandanteController,
            decoration: const InputDecoration(labelText: 'Setor Demandante'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o setor demandante.';
              }
              return null;
            },
          ),
          // TODO: Adicionar mais campos do formulário aqui (Modalidade, Assessor, Fases, etc.)
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Salvar Processo'),
            ),
          ),
        ],
      ),
    );
  }
}
