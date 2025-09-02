import 'package:flutter/material.dart';
import 'upload_screen.dart';
import 'test_history_screen.dart';
import 'tips_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';
import 'faq_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('OculoCheck'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'tips':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TipsScreen()),
                  );
                  break;
                case 'settings':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                  break;
                case 'about':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutScreen()),
                  );
                  break;
                case 'faq':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FaqScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'tips', child: Text('Conseils')),
              PopupMenuItem(value: 'settings', child: Text('Paramètres')),
              PopupMenuItem(value: 'faq', child: Text('FAQ')),
              PopupMenuItem(value: 'about', child: Text('À propos')),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.background, theme.colorScheme.surface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/OculoCheck_clear.png',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    'Diagnostic Intelligent des Maladies Oculaires',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Analysez vos photos oculaires avec notre technologie d\'intelligence artificielle pour détecter les maladies courantes.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  _buildDiseaseCard(
                    context,
                    'Rétinopathie Diabétique',
                    'assets/eye_diabetic_retinopathy.jpg',
                    'Complication du diabète affectant la rétine. Détection précoce essentielle pour préserver la vision.',
                    const Color(0xFFE53E3E),
                  ),

                  const SizedBox(height: 16),

                  _buildDiseaseCard(
                    context,
                    'Glaucome',
                    'assets/eye_glaucoma.jpg',
                    'Augmentation de la pression intraoculaire pouvant endommager le nerf optique.',
                    const Color(0xFF3182CE),
                  ),

                  const SizedBox(height: 16),

                  _buildDiseaseCard(
                    context,
                    'Cataracte',
                    'assets/eye_cataract.jpg',
                    'Opacification du cristallin provoquant une vision floue et sensibilité à la lumière.',
                    const Color(0xFF38A169),
                  ),

                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? const Color(0xFF1A0F00)
                          : const Color(0xFFFEF5E7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFF92400E)
                            : const Color(0xFFF6AD55),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.brightness == Brightness.dark
                              ? const Color(0xFFF59E0B)
                              : const Color(0xFFDD6B20),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Ce diagnostic est informatif et ne remplace pas une consultation médicale professionnelle.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.brightness == Brightness.dark
                                  ? const Color(0xFFF59E0B)
                                  : const Color(0xFFDD6B20),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- Boutons harmonisés ---
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt, size: 24),
                          label: const Text('Nouveau diagnostic'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const UploadScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            minimumSize: const Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            shadowColor: theme.colorScheme.primary.withOpacity(0.3),
                            textStyle: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.history, size: 24),
                          label: const Text('Historique'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const TestHistoryScreen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.primary,
                            side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            minimumSize: const Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiseaseCard(
      BuildContext context,
      String title,
      String imagePath,
      String description,
      Color accentColor,
      ) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shadowColor: accentColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accentColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.medical_services,
                        color: accentColor,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
