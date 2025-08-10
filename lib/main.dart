import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const EyeDiseaseApp());
}

class EyeDiseaseApp extends StatelessWidget {
  const EyeDiseaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diagnostic des Maladies Oculaires',
      theme: ThemeData(
        // Updated primary color based on logo
        primaryColor: const Color(0xFF003366), // Deep blue
        scaffoldBackgroundColor: const Color(0xFFF5F9FC), // Light off-white background

        // AppBar style
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF003366), // Deep blue
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),

        // Button styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00C2C2), // Turquoise
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Card style
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Text theme
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
