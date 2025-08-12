import 'dart:io';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String prediction;
  final double confidence;
  final String imagePath;

  const ResultScreen({
    required this.prediction,
    required this.confidence,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats d\'Analyse'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFF1F5F9),
            ],
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

                  Card(
                    elevation: 4,
                    shadowColor: _getResultColor(prediction).withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _getResultColor(prediction).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: _getResultColor(prediction).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getResultIcon(prediction),
                                size: 64,
                                color: _getResultColor(prediction),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            Text(
                              _getResultTitle(prediction),
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: _getResultColor(prediction),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: _getResultColor(prediction).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: _getResultColor(prediction).withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                'Confiance: ${confidence.toStringAsFixed(1)}%',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: _getResultColor(prediction),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Card(
                    elevation: 4,
                    shadowColor: theme.colorScheme.shadow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(imagePath),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Card(
                    elevation: 4,
                    shadowColor: theme.colorScheme.shadow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: theme.colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Détails du Diagnostic',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 20),
                          
                          Text(
                            _getResultDescription(prediction),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              height: 1.6,
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _getResultColor(prediction).withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _getResultColor(prediction).withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.recommend,
                                      color: _getResultColor(prediction),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Recommandations',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        color: _getResultColor(prediction),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  _getRecommendations(prediction),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Card(
                    elevation: 2,
                    shadowColor: const Color(0xFFF6AD55).withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF5E7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFF6AD55),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.medical_services,
                              color: const Color(0xFFDD6B20),
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Avertissement Médical',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: const Color(0xFFDD6B20),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Ce diagnostic est informatif et ne remplace pas une consultation médicale professionnelle. Consultez un ophtalmologue pour un diagnostic complet.',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFFDD6B20),
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
                  ),

                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('Nouvelle Analyse'),
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text('Partager'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Fonctionnalité de partage à venir'),
                                backgroundColor: theme.colorScheme.primary,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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

  Color _getResultColor(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return const Color(0xFF38A169);
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return const Color(0xFFE53E3E);
      case 'glaucoma':
      case 'glaucome':
        return const Color(0xFF3182CE);
      case 'cataract':
      case 'cataracte':
        return const Color(0xFF805AD5);
      default:
        return const Color(0xFF2E5BBA);
    }
  }

  IconData _getResultIcon(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return Icons.check_circle;
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return Icons.warning;
      case 'glaucoma':
      case 'glaucome':
        return Icons.visibility_off;
      case 'cataract':
      case 'cataracte':
        return Icons.blur_on;
      default:
        return Icons.medical_services;
    }
  }

  String _getResultTitle(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return 'Aucune Maladie Détectée';
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return 'Rétinopathie Diabétique Détectée';
      case 'glaucoma':
      case 'glaucome':
        return 'Glaucome Détecté';
      case 'cataract':
      case 'cataracte':
        return 'Cataracte Détectée';
      default:
        return 'Résultat: $result';
    }
  }

  String _getResultDescription(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return 'Votre œil semble en bonne santé. Aucun signe de maladie oculaire n\'a été détecté dans l\'image analysée.';
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return 'Des signes de rétinopathie diabétique ont été détectés dans votre image. Cette condition affecte les vaisseaux sanguins de la rétine et peut entraîner une perte de vision si elle n\'est pas traitée.';
      case 'glaucoma':
      case 'glaucome':
        return 'Des signes de glaucome ont été détectés dans votre image. Cette maladie endommage le nerf optique et peut causer une perte de vision permanente.';
      case 'cataract':
      case 'cataracte':
        return 'Des signes de cataracte ont été détectés dans votre image. Cette condition provoque une opacification du cristallin, entraînant une vision floue.';
      default:
        return 'Résultat d\'analyse: $result';
    }
  }

  String _getRecommendations(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return '• Continuez à maintenir une bonne hygiène oculaire\n• Passez des examens oculaires réguliers\n• Protégez vos yeux du soleil avec des lunettes UV\n• Maintenez une alimentation équilibrée riche en vitamines A, C et E';
      case 'diabetic retinopathy':
      case 'rétinopathie diabétique':
        return '• Consultez immédiatement un ophtalmologue\n• Contrôlez votre glycémie avec votre médecin\n• Évitez de fumer et maintenez une tension artérielle normale\n• Passez des examens oculaires plus fréquents';
      case 'glaucoma':
      case 'glaucome':
        return '• Consultez un ophtalmologue dans les plus brefs délais\n• Évitez les activités qui augmentent la pression oculaire\n• Suivez strictement le traitement prescrit\n• Passez des examens de suivi réguliers';
      case 'cataract':
      case 'cataracte':
        return '• Consultez un ophtalmologue pour évaluation\n• Utilisez un éclairage approprié pour la lecture\n• Évitez de conduire la nuit si la vision est affectée\n• Discutez des options de traitement chirurgical';
      default:
        return '• Consultez un professionnel de la santé oculaire\n• Suivez les recommandations médicales\n• Maintenez des examens réguliers';
    }
  }
}