// lib/core/providers/auth_provider.dart
// Provedores Riverpod para gerenciar a instância do Firebase Auth e o estado de autenticação.
import 'package:firebase_auth/firebase_auth.dart'
    as FBAuth; // Alias para User do Firebase
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

// Provedor que expõe a instância do Firebase Auth
final firebaseAuthProvider = Provider<FBAuth.FirebaseAuth>(
  (ref) => FBAuth.FirebaseAuth.instance,
);

// Provedor para gerenciar o estado de autenticação do utilizador (stream de User? do Firebase)
// Retorna um AsyncValue<FBAuth.User?>
final authStateProvider = StreamProvider<FBAuth.User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

// Provedor de estado para gerenciar o processo de autenticação usando o AuthService
// Correção: Garante que o AuthService é criado com a instância correta do FirebaseAuth
final authServiceProvider = Provider<AuthService>((ref) {
  // O AuthService precisa da instância do FirebaseAuth
  final firebaseAuthInstance = ref.watch(firebaseAuthProvider);
  return AuthService(firebaseAuthInstance);
});
