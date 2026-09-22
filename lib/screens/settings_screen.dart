import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  String themeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Mode clair';
      case ThemeMode.dark:
        return 'Mode sombre';
      case ThemeMode.system:
        return 'Selon le système';
    }
  }

  IconData themeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Apparence',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButtonFormField<ThemeMode>(
                initialValue: themeMode,
                decoration: InputDecoration(
                  labelText: 'Thème',
                  prefixIcon: Icon(themeIcon(themeMode)),
                  border: const OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Mode clair'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Mode sombre'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('Selon le système'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onThemeChanged(value);
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home),
            label: const Text('Retour à l’accueil'),
          ),
        ],
      ),
    );
  }
}