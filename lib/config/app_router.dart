// Placeholder: lib/config/app_router.dart
// Configuração de roteamento (exemplo básico com go_router)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:acao_licita/features/auth/screens/login_page.dart';
import 'package:acao_licita/features/auth/screens/signup_page.dart';
import 'package:acao_licita/features/dashboard/screens/dashboard_page.dart';
import 'package:acao_licita/features/process_management/screens/new_process_page.dart';
import 'package:acao_licita/features/process_management/screens/process_detail_page.dart';
import 'package:acao_licita/core/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acao_licita/core/models/user.dart'; // Importa AppUser

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const LoginPage(), // Página inicial será o login
    ),
    GoRoute(
      path: '/signup', // Rota para a tela de cadastro
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/new-process', // Rota para cadastro de processo
      builder: (context, state) => const NewProcessPage(),
    ),
    GoRoute(
      path: '/process-detail/:id', // Rota para detalhes do processo com ID
      builder: (context, state) {
        final processId = state.pathParameters['id']!;
        return ProcessDetailPage(processId: processId);
      },
    ),
  ],
  redirect: (context, state) {
    // Lógica de redirecionamento para UI Testes
    // O authStateProvider agora simula o estado de login.
    final AppUser? authUser = ProviderScope.containerOf(
      context,
    ).read(authStateProvider);
    final loggedInSimulated =
        authUser != null; // Verifica se há um usuário simulado

    // O getter 'location' foi substituído por 'fullPath' para obter a rota atual
    final String location = state.fullPath ?? '/'; // Garante que não seja nulo

    // Se estiver simuladamente logado e tentando ir para login ou cadastro, redireciona para o dashboard
    if (loggedInSimulated && (location == '/' || location == '/signup')) {
      return '/dashboard';
    }

    // Se NÃO estiver simuladamente logado e tentando acessar uma rota protegida (não login/cadastro),
    // redireciona para o login.
    if (!loggedInSimulated && (location != '/' && location != '/signup')) {
      return '/';
    }

    return null; // Nenhuma redireção necessária
  },
);
