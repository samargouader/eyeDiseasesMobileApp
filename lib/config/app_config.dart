class AppConfig {
  // App Information
  static const String appName = 'OculoCheck';
  static const String appVersion = '1.0.0';
  
  // TFLite Model Configuration
  static const String modelPath = 'assets/my_model.tflite';
  static const String labelsPath = 'assets/labels.txt';
  static const int modelInputSize = 224;
  static const int modelInputChannels = 3;
  
  // Model compatibility settings
  static const bool enableModelFallback = true;
  static const bool showModelErrors = true;
  
  // Database Configuration
  static const bool enableDatabase = true;
  static const bool enableDatabaseLogging = true;
  
  // UI Configuration
  static const bool enableAnimations = true;
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // Error Handling
  static const Duration errorSnackBarDuration = Duration(seconds: 4);
  static const Duration successSnackBarDuration = Duration(seconds: 2);
  
  // Image Processing
  static const int maxImageSize = 1024;
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];
  
  // Development vs Production
  static const bool isDevelopment = true; // Change to false for production
  
  // Feature Flags
  static const bool enableTestHistory = true;
  static const bool enableUserProfile = true;
  static const bool enableImageUpload = true;
  
  // Debug Settings
  static const bool enableDebugLogging = true;
  static const bool showDebugInfo = false;
}
