// lib/features/auth/widgets/login_form.dart
// Este widget encapsula o formulário de login/registo com design aprimorado.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Necessário para FirebaseAuthException
import '../../../core/providers/auth_provider.dart'; // Provedores de autenticação
import 'package:go_router/go_router.dart'; // Para navegação

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário
  bool _isLoading = false; // Estado de carregamento para o botão

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Função para submeter o formulário (Login ou Registo)
  Future<void> _submitLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Ativa o estado de carregamento
      });
      try {
        final authService = ref.read(
          authServiceProvider,
        ); // Obtém o serviço de autenticação

        await authService.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login bem-sucedido!')));
        // A navegação para o dashboard será tratada pelo redirect do GoRouter
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: ${e.message}')));
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ocorreu um erro inesperado: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Desativa o estado de carregamento
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.email),
              filled: true, // Fundo preenchido
              fillColor: Theme.of(context).colorScheme.surfaceVariant
                  .withOpacity(0.2), // Cor de preenchimento
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um e-mail.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Palavra-passe',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.lock),
              filled: true, // Fundo preenchido
              fillColor: Theme.of(context).colorScheme.surfaceVariant
                  .withOpacity(0.2), // Cor de preenchimento
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira uma palavra-passe.';
              }
              if (value.length < 6) {
                return 'A palavra-passe deve ter pelo menos 6 caracteres.';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _submitLogin,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 4, // Adiciona sombra ao botão
            ),
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Entrar', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _isLoading
                ? null
                : () {
                    context.go('/signup'); // Navega para a página de registo
                  },
            child: Text(
              'Não tem uma conta? Crie uma.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ), // Mais destaque
            ),
          ),
          // REMOVIDO: O botão "Entrar com Google" foi removido daqui para evitar duplicação.
          // Ele será gerido pelo GoogleSignInButton na LoginPage.
        ],
      ),
    );
  }
}
