import 'package:flutter/material.dart';
import 'upload_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnostic des Maladies Oculaires'),
        centerTitle: true,
        backgroundColor: const Color(0xFF008080),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFF1F8E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Bienvenue dans l’application de diagnostic des maladies oculaires.',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF008080)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                DiseaseIntroCard(
                  title: 'Rétinopathie diabétique',
                  imagePath: 'assets/eye_diabetic_retinopathy.jpg',
                  description: "La rétinopathie diabétique est une complication du diabète qui affecte la rétine et peut entraîner une perte de vision si elle n'est pas traitée à temps.",
                ),
                DiseaseIntroCard(
                  title: 'Glaucome',
                  imagePath: 'assets/eye_glaucoma.jpg',
                  description: "Le glaucome est une maladie oculaire caractérisée par une augmentation de la pression intraoculaire, pouvant endommager le nerf optique et causer la cécité.",
                ),
                DiseaseIntroCard(
                  title: 'Cataracte',
                  imagePath: 'assets/eye_cataract.jpg',
                  description: "La cataracte est une opacification du cristallin de l'œil, provoquant une vision floue et une sensibilité à la lumière.",
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Commencer le diagnostic'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UploadScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008080),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiseaseIntroCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  const DiseaseIntroCard({
    required this.title,
    required this.imagePath,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF008080),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 15),
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