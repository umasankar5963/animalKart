import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme_provider.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Switch.adaptive(
      value: theme.isDarkMode,
      onChanged: (value) => theme.toggleTheme(value),
      activeColor: Theme.of(context).colorScheme.secondary,
      activeTrackColor: Colors.grey[500],
      inactiveThumbColor: Colors.grey[200],
      inactiveTrackColor: Colors.grey[400],
    );
  }
}
