// lib/config/app_router.dart
// Configuração do roteador GoRouter para navegação na aplicação.
import 'package:acao_licita/features/process_management/screens/new_process_page.dart';
import 'package:acao_licita/features/process_management/screens/process_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/auth_provider.dart'; // Importa o provedor de autenticação
import '../features/auth/screens/login_page.dart'; // Importa a página de login
import '../features/dashboard/screens/dashboard_page.dart'; // Importa a página do dashboard
import '../features/auth/screens/signup_page.dart'; // Importa a página de registo

// Variável de simulação para testes de UI sem Firebase ativo
// Defina como 'true' para simular um utilizador autenticado e aceder ao dashboard.
// Defina como 'false' para testar o fluxo de login/registo.
const bool _simulateLoggedIn =
    false; // <--- MANTENHA COMO 'true' PARA TESTAR O DASHBOARD

final goRouterProvider = Provider<GoRouter>((ref) {
  // Observa o estado de autenticação do utilizador (do Firebase).
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/', // Define a rota inicial
    routes: [
      // Rota para a página de login
      GoRoute(
        path: '/',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      // Rota para a página de registo
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupPage(),
      ),
      // Rota para a página do dashboard
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      // Adicione outras rotas aqui conforme a aplicação cresce
      GoRoute(
        path: '/new-process', // Rota para cadastro de processo
        name: 'new-process',
        builder: (context, state) =>
            const NewProcessPage(), // Substitua por NewProcessPage()
      ),
      GoRoute(
        path: '/process-detail/:id', // Rota para detalhes do processo com ID
        name: 'process-detail',
        builder: (context, state) {
          final processId = state.pathParameters['id'] ?? '';
          return ProcessDetailPage(
            processId: processId,
          ); // Substitua por ProcessDetailPage($processId)
        },
      ),
    ],
    // Lógica de redirecionamento baseada no estado de autenticação (e simulação)
    redirect: (context, state) {
      // Se a simulação estiver ativa, sempre consideramos logado para o redirecionamento.
      final bool loggedIn = _simulateLoggedIn
          ? true
          : (authState.value != null);

      final bool tryingToAuth =
          state.fullPath == '/' || state.fullPath == '/signup';

      if (!loggedIn) {
        return tryingToAuth ? null : '/';
      }

      if (loggedIn) {
        return tryingToAuth ? '/dashboard' : null;
      }

      return null;
    },
  );
});
