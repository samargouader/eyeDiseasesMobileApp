import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conseils pour dispositifs spécialisés'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _TipCard(
            icon: Icons.center_focus_strong,
            title: 'Champ et centrage',
            description:
                "Remplissez le cadre avec le fond d'œil ou la zone visée. Centrez la papille ou la zone d'intérêt selon le protocole.",
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 12),
          _TipCard(
            icon: Icons.photo_camera_back,
            title: 'Réglages de l\'appareil',
            description:
                "Utilisez sRGB, désactivez les filtres beauté, préférez JPEG haute qualité. Stabilisez l\'appareil (trépied/support).",
            color: Colors.indigo.shade700,
          ),
          const SizedBox(height: 12),
          _TipCard(
            icon: Icons.manage_search,
            title: 'Mise au point et reflets',
            description:
                "Assurez une mise au point parfaite. Réduisez les reflets cornéens en ajustant l\'angle ou la lumière du dispositif.",
            color: Colors.teal.shade700,
          ),
          const SizedBox(height: 12),
          _TipCard(
            icon: Icons.color_lens,
            title: 'Cohérence colorimétrique',
            description:
                "Gardez des réglages constants (balance des blancs, exposition). Évitez les dominantes de couleur.",
            color: Colors.amber.shade700,
          ),
          const SizedBox(height: 12),
          _TipCard(
            icon: Icons.shutter_speed,
            title: 'Résolution et compression',
            description:
                "Résolution ≥ 2048 px côté long, compression faible (qualité élevée). Recadrez plutôt que réduire fortement.",
            color: Colors.deepOrange.shade700,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Retour'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _TipCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
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
    );
  }
}


