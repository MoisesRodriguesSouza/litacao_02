// Placeholder: lib/features/auth/widgets/google_sign_in_button.dart
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Lógica de login com Google (a ser implementada)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login com Google (a ser implementado)'),
          ),
        );
      },
      icon: Image.network(
        'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
        height: 24.0,
      ),
      label: const Text('Entrar com Google'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50), // Botão de largura total
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        foregroundColor: Colors.black, // Cor do texto
        backgroundColor: Colors.white, // Cor de fundo
        side: const BorderSide(color: Colors.grey),
      ),
    );
  }
}
