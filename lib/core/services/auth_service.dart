// Placeholder: lib/core/services/auth_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acao_licita/core/providers/auth_provider.dart';
import 'package:acao_licita/core/models/user.dart'; // Importa o modelo de usuário simplificado

class AuthService {
  final Ref _ref;

  AuthService(this._ref);

  Future<void> signInWithEmailPassword(String email, String password) async {
    print('Simulando login para $email');
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simula uma requisição de rede

    if (email == 'teste@exemplo.com' && password == 'senha123') {
      // Simula um usuário logado
      final simulatedUser = AppUser(
        uid: 'simulated_user_id',
        email: email,
        displayName: 'Usuário de Teste',
        role: 'gestor',
        setorId: 'setor_a',
      );
      _ref.read(authStateProvider.notifier).state = simulatedUser;
    } else {
      throw Exception('Usuário ou senha inválidos (simulado).');
    }
  }

  Future<void> signUpWithEmailPassword(String email, String password) async {
    print('Simulando cadastro para $email');
    await Future.delayed(const Duration(seconds: 2));

    if (email.contains('@') && password.length >= 6) {
      // Não faz login automático após o cadastro, apenas simula o sucesso.
      // O usuário precisará fazer login manualmente após o cadastro simulado.
    } else {
      throw Exception('Email inválido ou senha muito curta (simulado).');
    }
  }

  Future<void> signOut() async {
    print('Simulando logout');
    await Future.delayed(const Duration(milliseconds: 500));
    _ref.read(authStateProvider.notifier).state =
        null; // Limpa o usuário logado simulado
  }
}
