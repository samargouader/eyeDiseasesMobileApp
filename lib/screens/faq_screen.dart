import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final faqs = <Map<String, String>>[
      {
        'q': "Le diagnostic est-il fiable ?",
        'a': "Il s'agit d'une estimation basée sur l'image fournie. Même avec un appareil spécialisé, cela ne remplace pas une consultation médicale.",
      },
      {
        'q': "Quelles maladies sont couvertes ?",
        'a': "Rétinopathie diabétique, glaucome et cataracte dans cette version.",
      },
      {
        'q': "Comment préparer les images d'un dispositif spécialisé ?",
        'a': "Exportez en JPEG/PNG profil sRGB, résolution ≥ 2048 px, faible compression. Évitez les filtres et gardez des réglages constants.",
      },
      {
        'q': "Puis-je importer du RAW/TIFF/DICOM ?",
        'a': "Non directement. Convertissez en JPEG/PNG (sRGB). Conservez le cadrage et la netteté lors de l'export.",
      },
      {
        'q': "Mes données sont-elles stockées ?",
        'a': "Vous pouvez choisir de sauvegarder les tests localement. Aucune donnée n'est envoyée en ligne par l'application.",
      },
      {
        'q': "Que faire en cas de reflets ou artefacts ?",
        'a': "Ajustez l'angle, réduisez l'illumination ou utilisez les réglages de votre dispositif pour minimiser les reflets cornéens.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final item = faqs[index];
          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 8),
            childrenPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
            title: Text(
              item['q']!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            children: [
              Text(
                item['a']!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


