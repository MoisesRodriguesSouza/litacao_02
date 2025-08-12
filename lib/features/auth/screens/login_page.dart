// Placeholder: lib/features/auth/screens/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acao_licita/features/auth/widgets/login_form.dart';
import 'package:acao_licita/features/auth/widgets/google_sign_in_button.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login - AÇÃO LÍCITA')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/app_logo.png', height: 100), // Comentado para evitar erro sem arquivo real
              const SizedBox(height: 24),
              const Text(
                'Bem-vindo ao AÇÃO LÍCITA!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const LoginForm(), // Componente de formulário de login
              const SizedBox(height: 16),
              const Text('ou'),
              const SizedBox(height: 16),
              const GoogleSignInButton(), // Botão de login com Google
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.go('/signup'); // Navegar para tela de cadastro
                },
                child: const Text('Não tem uma conta? Cadastre-se'),
              ),
              TextButton(
                onPressed: () {
                  // Navegar para tela de recuperação de senha
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Recuperação de Senha (a ser implementado)',
                      ),
                    ),
                  );
                },
                child: const Text('Esqueceu sua senha?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
