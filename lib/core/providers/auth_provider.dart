// Placeholder: lib/core/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acao_licita/core/models/user.dart'; // Importa o modelo de usuário simplificado
import 'package:acao_licita/core/services/auth_service.dart'; // Importação adicionada/verificada

// Provedor que expõe o estado de autenticação (simulado)
final authStateProvider = StateProvider<AppUser?>(
  (ref) => null,
); // Inicialmente sem usuário logado

// Provedor para o serviço de autenticação
final authServiceProvider = Provider((ref) => AuthService(ref));
