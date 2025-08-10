import 'package:flutter/material.dart';
import 'upload_page.dart';

class EyeDiseasesHomePage extends StatefulWidget {
  const EyeDiseasesHomePage({super.key, required this.title});

  final String title;

  @override
  State<EyeDiseasesHomePage> createState() => _EyeDiseasesHomePageState();
}

class _EyeDiseasesHomePageState extends State<EyeDiseasesHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003366), Color(0xFF0096D6)], // Dark blue to bright blue
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Logo Header
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFF003366),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/OculoCheck.png', // Use your logo here
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(1.5, 1.5),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Introduction aux Maladies des Yeux',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF003366), // Title dark blue
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Les maladies des yeux comme la cataracte, la rétinopathie diabétique et le glaucome peuvent affecter la vision. Cette application utilise une intelligence artificielle pour analyser vos photos oculaires et détecter ces affections. Explorez les exemples ci-dessous et commencez votre diagnostic !',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/eye_cataract.jpg',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/eye_glaucoma.jpg',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00C2C2), // Teal/turquoise
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UploadPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Uploader une Photo',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
