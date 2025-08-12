// Placeholder: lib/shared/widgets/theme_switcher.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provedor para gerenciar o tema (claro/escuro)
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      ),
      onPressed: () {
        ref.read(themeModeProvider.notifier).state =
            themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      },
      tooltip: 'Alternar Tema',
    );
  }
}
