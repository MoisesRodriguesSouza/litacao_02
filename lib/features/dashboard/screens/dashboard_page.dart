// lib/features/dashboard/screens/dashboard_page.dart
// Ecrã do Dashboard, exibido após o login bem-sucedido.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Alias para User do Firebase
import '../../../core/providers/auth_provider.dart'; // Provedores de autenticação

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa o estado de autenticação do utilizador.
    // Isso fará com que o widget seja reconstruído quando o estado de autenticação mudar.
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Ícone de terminar sessão
            onPressed: () async {
              // Chama o serviço de autenticação para terminar a sessão do utilizador
              await ref.read(authServiceProvider).signOut();
            },
          ),
        ],
      ),
      body: authState.when(
        data: (user) {
          // Se houver dados (utilizador autenticado ou nulo após logout)
          if (user != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bem-vindo(a) à AÇÃO LÍCITA!',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Utilizador: ${user.email}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          } else {
            // Se o utilizador for nulo (ex: após logout), pode redirecionar ou mostrar uma mensagem
            // O GoRouter já deve lidar com o redirecionamento para a página de login.
            return const Center(
              child: Text('Não autenticado. Redirecionando...'),
            );
          }
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ), // Mostra um indicador de carregamento
        error: (error, stack) =>
            Center(child: Text('Erro: $error')), // Exibe erros
      ),
    );
  }
}
