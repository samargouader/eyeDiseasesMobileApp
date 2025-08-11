class DatabaseConfig {
  // MySQL Database Configuration
  // Update these values according to your MySQL server setup
  
  // Local development (XAMPP/WAMP/MAMP)
  static const String host = 'localhost';
  static const int port = 3306;
  static const String user = 'root';
  static const String password = '';
  static const String database = 'oculocheck';
  
  // For production, you might want to use environment variables:
  // static const String host = String.fromEnvironment('DB_HOST', defaultValue: 'localhost');
  // static const String user = String.fromEnvironment('DB_USER', defaultValue: 'root');
  // static const String password = String.fromEnvironment('DB_PASSWORD', defaultValue: '');
  // static const String database = String.fromEnvironment('DB_NAME', defaultValue: 'oculocheck');
  
  // Connection timeout settings
  static const int connectionTimeout = 30; // seconds
  static const int queryTimeout = 60; // seconds
  
  // Connection pool settings (if needed)
  static const int maxConnections = 10;
  static const int minConnections = 1;
}
