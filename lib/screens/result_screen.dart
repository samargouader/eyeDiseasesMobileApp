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
    return Scaffold(
      appBar: AppBar(title: Text('Résultats')),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.file(File(imagePath), // Ou Image.asset si vous sauvegardez
        SizedBox(height: 20),
        Text(
          'Résultat: $prediction',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'Confiance: ${confidence.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('RETOUR'),
        ),
        ],
      ),
    ),
    );
  }
}