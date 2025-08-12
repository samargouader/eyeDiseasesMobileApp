import 'package:flutter/material.dart';
import '../config/theme_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool hapticsEnabled = true;
  bool savePhotos = false;
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Général', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          SwitchListTile(
            value: hapticsEnabled,
            onChanged: (v) => setState(() => hapticsEnabled = v),
            title: const Text('Vibrations/Haptique'),
            subtitle: const Text('Feedback lors des actions'),
          ),
          SwitchListTile(
            value: savePhotos,
            onChanged: (v) => setState(() => savePhotos = v),
            title: const Text('Sauvegarder les photos'),
            subtitle: const Text('Enregistrer localement les images utilisées'),
          ),
          const Divider(height: 32),
          Text('Apparence', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<ThemeMode>(
            value: ThemeController.instance.themeMode,
            items: const [
              DropdownMenuItem(value: ThemeMode.system, child: Text('Système')),
              DropdownMenuItem(value: ThemeMode.light, child: Text('Clair')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('Sombre')),
            ],
            onChanged: (v) {
              final selected = v ?? ThemeMode.system;
              ThemeController.instance.setThemeMode(selected);
              setState(() => themeMode = selected);
            },
            decoration: const InputDecoration(
              labelText: 'Thème',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.save),
            label: const Text('Enregistrer'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}


