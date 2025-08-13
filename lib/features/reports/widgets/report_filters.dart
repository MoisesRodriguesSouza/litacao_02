// lib/features/reports/widgets/report_filters.dart
// Widget para aplicar filtros em relatórios.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportFilters extends ConsumerStatefulWidget {
  const ReportFilters({super.key});

  @override
  ConsumerState<ReportFilters> createState() => _ReportFiltersState();
}

class _ReportFiltersState extends ConsumerState<ReportFilters> {
  String? _selectedSetor;
  String? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  // Lista de setores de exemplo (substituir por dados reais do Firestore)
  final List<String> _setores = [
    'Administração',
    'Compras',
    'Patrimônio',
    'Secretaria de Educação',
    'Frota',
    'Finanças',
    'TI',
    'Meio Ambiente',
    'Gabinete',
    'Arquivo',
    'Eventos',
    'Obras',
    'Segurança',
  ];
  // Lista de status de exemplo
  final List<String> _status = [
    'Em Elaboração',
    'Em Andamento',
    'Em Habilitação',
    'Adjudicado',
    'Concluído',
    'Extinto',
  ];

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _applyFilters() {
    // TODO: Implementar lógica para aplicar os filtros e buscar dados do relatório
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Filtros aplicados: Setor: ${_selectedSetor ?? "Todos"}, Status: ${_selectedStatus ?? "Todos"}, '
          'Período: ${_startDate?.toIso8601String().split('T').first ?? "N/A"} a ${_endDate?.toIso8601String().split('T').first ?? "N/A"}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Setor de Origem'),
          value: _selectedSetor,
          items: ['Todos', ..._setores].map((String setor) {
            return DropdownMenuItem<String>(
              value: setor == 'Todos' ? null : setor,
              child: Text(setor),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedSetor = newValue;
            });
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Status do Processo'),
          value: _selectedStatus,
          items: ['Todos', ..._status].map((String status) {
            return DropdownMenuItem<String>(
              value: status == 'Todos' ? null : status,
              child: Text(status),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedStatus = newValue;
            });
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data Início',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _startDate == null
                        ? 'Selecionar Data'
                        : _startDate!.toIso8601String().split('T').first,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data Fim',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _endDate == null
                        ? 'Selecionar Data'
                        : _endDate!.toIso8601String().split('T').first,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton(
            onPressed: _applyFilters,
            child: const Text('Gerar Relatório'),
          ),
        ),
      ],
    );
  }
}
