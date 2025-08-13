// lib/core/services/auth_service.dart
// Lógica de serviço para autenticação com Firebase Authentication.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth; // Instância do FirebaseAuth

  // O construtor agora espera apenas a instância do FirebaseAuth.
  AuthService(this._auth);

  // Método para fazer login com e-mail e palavra-passe
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Método para registar um novo utilizador com e-mail e palavra-passe
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Método para fazer login com a conta Google
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn()
        .signIn(); // Inicia o fluxo de login do Google
    if (googleUser == null) {
      // Se o utilizador cancelar o login do Google, retorna
      return;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication; // Obtém as credenciais do Google
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(
      credential,
    ); // Autentica no Firebase com as credenciais do Google
  }

  // Método para terminar a sessão do utilizador
  Future<void> signOut() async {
    await _auth.signOut(); // Termina a sessão do Firebase
    await GoogleSignIn()
        .signOut(); // Opcional: Termina a sessão do Google se o utilizador usou o login do Google
  }

  // A lógica de simulação de login foi removida daqui.
  // Ela deve ser tratada no app_router.dart ou em testes.
}
