// lib/features/auth/screens/login_page.dart
// Tela de Login e Registo de utilizadores com design aprimorado.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/login_form.dart'; // Importa o widget do formulário de login
import '../widgets/google_sign_in_button.dart'; // Importa o widget do botão Google

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey.shade100, // Fundo mais claro para destacar o cartão
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0), // Aumenta o padding
          child: ConstrainedBox(
            // Limita a largura máxima do formulário em telas grandes
            constraints: const BoxConstraints(maxWidth: 450),
            child: Card(
              color: Colors
                  .white, // Fundo branco sólido para o cartão para um contraste nítido
              elevation: 12, // Aumenta a sombra para um destaque ainda maior
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ), // Bordas mais arredondadas para elegância
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, // Estica os elementos horizontalmente
                  children: [
                    // Adicionando o logo da aplicação
                    Image.asset(
                      '/acao_logo.png', // Caminho para o logo
                      width: 200,
                      height: 400, // Aumentado o tamanho para 180 (era 120)
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          'AÇÃO LÍCITA', // Fallback para texto se o logo não carregar
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    // Removido o SizedBox(height: 16) e o Text duplicado
                    const SizedBox(height: 32), // Espaçamento após o logo
                    LoginForm(), // O LoginForm agora contém os campos e o botão de Entrar/Ir para Registo
                    const SizedBox(height: 24),
                    const Divider(
                      height: 32,
                      thickness: 1,
                      color: Colors.grey,
                    ), // Divisor mais discreto
                    const SizedBox(height: 24),
                    GoogleSignInButton(), // Botão de login com Google
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
