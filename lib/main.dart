// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Para gerenciamento de estado

// Importações para a estrutura de pastas sugerida
import 'package:acao_licita/config/app_router.dart';
import 'package:acao_licita/core/providers/auth_provider.dart';

// Variáveis globais para configuração do Firebase (mantidas como placeholders, mas não usadas)
const String firebaseConfigString = String.fromEnvironment('FIREBASE_CONFIG');
const String initialAuthToken = String.fromEnvironment('INITIAL_AUTH_TOKEN');
const String appId = String.fromEnvironment(
  'APP_ID',
); // ID do aplicativo no Canvas

// A função main() é o ponto de entrada do seu aplicativo Flutter.
// Ela deve ser uma função de nível superior (não dentro de uma classe)
// e chamar runApp() para iniciar a árvore de widgets.
void main() {
  // Garante que a função main seja definida aqui.
  WidgetsFlutterBinding.ensureInitialized(); // Garante que os widgets estejam inicializados

  // --- Configuração do Firebase (temporariamente desabilitada para foco na UI) ---
  // print('Firebase initialization skipped for UI development.');
  // ---------------------------------------------------------------------------------

  // Inicia o aplicativo Flutter com Riverpod
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa o estado de autenticação simulado
    final authState = ref.watch(authStateProvider);

    return MaterialApp.router(
      title: 'AÇÃO LÍCITA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Tema padrão claro
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Tema padrão escuro
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      routerConfig:
          appRouter, // Usando o roteador configurado em config/app_router.dart
    );
  }
}
