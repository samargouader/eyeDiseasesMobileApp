import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'config/theme_controller.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    final databaseService = DatabaseService();
    await databaseService.initializeDatabase();
    print('Database initialized successfully');
  } catch (e) {
    print('Error initializing database: $e');
  }
  
  runApp(const EyeDiseaseApp());
}

class EyeDiseaseApp extends StatelessWidget {
  const EyeDiseaseApp({super.key});

  ThemeData _buildLightTheme() {
    return ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2E5BBA),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E5BBA),
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: Color(0x1A000000),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          iconTheme: IconThemeData(color: Colors.white, size: 24),
          centerTitle: true,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E5BBA),
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: const Color(0x1A2E5BBA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF2E5BBA),
            side: const BorderSide(color: Color(0xFF2E5BBA), width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x0A000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A202C),
            letterSpacing: -0.5,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A202C),
            letterSpacing: -0.25,
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
            letterSpacing: 0.25,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
            letterSpacing: 0.15,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A202C),
            letterSpacing: 0.1,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A202C),
            letterSpacing: 0.1,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF2D3748),
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF2D3748),
            height: 1.5,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFF4A5568),
            height: 1.4,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2E5BBA),
            letterSpacing: 0.1,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2E5BBA),
            letterSpacing: 0.5,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2E5BBA),
            letterSpacing: 0.5,
          ),
        ),

        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF2E5BBA),
          onPrimary: Colors.white,
          secondary: Color(0xFF38B2AC),
          onSecondary: Colors.white,
          tertiary: Color(0xFF48BB78),
          onTertiary: Colors.white,
          error: Color(0xFFE53E3E),
          onError: Colors.white,
          background: Color(0xFFF8FAFC),
          onBackground: Color(0xFF1A202C),
          surface: Colors.white,
          onSurface: Color(0xFF1A202C),
          surfaceVariant: Color(0xFFF7FAFC),
          onSurfaceVariant: Color(0xFF4A5568),
          outline: Color(0xFFE2E8F0),
          outlineVariant: Color(0xFFCBD5E0),
          shadow: Color(0x1A000000),
          scrim: Color(0x52000000),
          inverseSurface: Color(0xFF1A202C),
          onInverseSurface: Colors.white,
          inversePrimary: Color(0xFF90CDF4),
          surfaceTint: Color(0xFF2E5BBA),
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7FAFC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2E5BBA), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE53E3E)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: const TextStyle(color: Color(0xFF4A5568)),
          hintStyle: const TextStyle(color: Color(0xFFA0AEC0)),
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF2E5BBA),
          linearTrackColor: Color(0xFFE2E8F0),
          circularTrackColor: Color(0xFFE2E8F0),
        ),

        dividerTheme: const DividerThemeData(
          color: Color(0xFFE2E8F0),
          thickness: 1,
          space: 1,
        ),
      );
  }

  ThemeData _buildDarkTheme() {
    const bg = Color(0xFF000000);
    const surface = Color(0xFF0A0A0A);
    const onSurface = Color(0xFFE5E7EB);
    const outline = Color(0xFF1F1F1F);

    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      primaryColor: const Color(0xFF90CAF9),
      scaffoldBackgroundColor: bg,

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF000000),
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Color(0x1A000000),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 24),
        centerTitle: true,
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 3,
        shadowColor: const Color(0x40000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFFE5E7EB),
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFFE5E7EB),
          letterSpacing: -0.25,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE5E7EB),
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE5E7EB),
          letterSpacing: 0.25,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE5E7EB),
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE5E7EB),
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE5E7EB),
          letterSpacing: 0.15,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFE5E7EB),
          letterSpacing: 0.1,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFFE5E7EB),
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Color(0xFFD1D5DB),
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFFD1D5DB),
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xFF9CA3AF),
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF90CAF9),
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF90CAF9),
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0xFF90CAF9),
          letterSpacing: 0.5,
        ),
      ),

      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF90CAF9),
        onPrimary: Colors.black,
        secondary: Color(0xFF67E8F9),
        onSecondary: Colors.black,
        tertiary: Color(0xFF6EE7B7),
        onTertiary: Colors.black,
        error: Color(0xFFF87171),
        onError: Colors.black,
        background: bg,
        onBackground: onSurface,
        surface: surface,
        onSurface: onSurface,
        surfaceVariant: Color(0xFF000000),
        onSurfaceVariant: Color(0xFF94A3B8),
        outline: outline,
        outlineVariant: Color(0xFF0A0A0A),
        shadow: Color(0x1A000000),
        scrim: Color(0x52000000),
        inverseSurface: Color(0xFFE5E7EB),
        onInverseSurface: Color(0xFF0F172A),
        inversePrimary: Color(0xFF2563EB),
        surfaceTint: Color(0xFF90CAF9),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF000000),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF90CAF9), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF87171)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
        hintStyle: const TextStyle(color: Color(0xFF64748B)),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF90CAF9),
        linearTrackColor: Color(0xFF000000),
        circularTrackColor: Color(0xFF000000),
      ),

      dividerTheme: const DividerThemeData(
        color: Color(0xFF1F1F1F),
        thickness: 1,
        space: 1,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF90CAF9),
          side: const BorderSide(color: Color(0xFF90CAF9), width: 1.5),
        ),
      ),

      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'OculoCheck - Diagnostic Oculaire',
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          themeMode: mode,
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
