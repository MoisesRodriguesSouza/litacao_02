// Placeholder: lib/features/dashboard/screens/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acao_licita/core/providers/auth_provider.dart';
import 'package:acao_licita/shared/widgets/custom_app_bar.dart';
import 'package:acao_licita/shared/widgets/theme_switcher.dart';
import 'package:acao_licita/features/dashboard/widgets/kpi_card.dart'; // Importação adicionada/verificada
import 'package:acao_licita/features/dashboard/widgets/process_list.dart'; // Importação adicionada/verificada
import 'package:go_router/go_router.dart';
import 'package:acao_licita/core/models/user.dart'; // Importa o modelo de usuário AppUser

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider);
    // Correção: Acessa o valor do StateProvider diretamente.
    // O 'user' será um AppUser? (pode ser nulo)
    final AppUser? user = ref.watch(authStateProvider);

    // Se o usuário for nulo (não logado), podemos redirecionar para o login
    // Esta parte do redirecionamento também pode ser tratada no app_router.dart,
    // mas ter uma verificação aqui é útil para o widget em si.
    if (user == null) {
      // Pequeno atraso para evitar erros de navegação síncronos
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/');
      });
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(), // Ou uma tela de carregamento/redirecionamento
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard - AÇÃO LÍCITA',
        actions: [
          ThemeSwitcher(), // Botão para alternar tema
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              // A navegação de volta para o login será tratada pelo redirect do GoRouter
            },
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${user.displayName ?? user.email ?? 'Usuário'}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            // Adicionar os cartões de visão geral (KPIs)
            Row(
              children: [
                Expanded(
                  child: KpiCard(
                    title: 'Processos Abertos',
                    value: '15', // Placeholder
                    icon: Icons.folder_open,
                    color: Colors.blue.shade100,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: KpiCard(
                    title: 'Em Andamento',
                    value: '8', // Placeholder
                    icon: Icons.pending_actions,
                    color: Colors.orange.shade100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: KpiCard(
                    title: 'Processos Parados',
                    value: '3', // Placeholder
                    icon: Icons.pause_circle_filled,
                    color: Colors.red.shade100,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: KpiCard(
                    title: 'Processos Finalizados',
                    value: '22', // Placeholder
                    icon: Icons.check_circle,
                    color: Colors.green.shade100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Processos Recentes',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: ProcessList(), // Lista de processos recentes (placeholder)
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/new-process'); // Navegar para a página de novo processo
        },
        child: const Icon(Icons.add),
        tooltip: 'Novo Processo',
      ),
    );
  }
}
