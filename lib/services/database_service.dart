import 'dart:async';
import 'package:mysql1/mysql1.dart';
import '../models/user.dart';
import '../models/test.dart';
import '../config/database_config.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static MySqlConnection? _connection;
  
  Future<MySqlConnection> get connection async {
    if (_connection != null) return _connection!;
    _connection = await _initConnection();
    return _connection!;
  }

  Future<MySqlConnection> _initConnection() async {
    final settings = ConnectionSettings(
      host: DatabaseConfig.host,
      port: DatabaseConfig.port,
      user: DatabaseConfig.user,
      password: DatabaseConfig.password,
      db: DatabaseConfig.database,
      timeout: Duration(seconds: DatabaseConfig.connectionTimeout),
    );
    
    try {
      final conn = await MySqlConnection.connect(settings);
      print('Connected to MySQL database: ${DatabaseConfig.database}');
      return conn;
    } catch (e) {
      print('Error connecting to MySQL database: $e');
      rethrow;
    }
  }

  // Initialize database tables
  Future<void> initializeDatabase() async {
    final conn = await connection;
    
    try {
      // Create users table
      await conn.query('''
        CREATE TABLE IF NOT EXISTS users (
          id INT AUTO_INCREMENT PRIMARY KEY,
          name VARCHAR(100) NOT NULL,
          lastName VARCHAR(100) NOT NULL,
          age INT NOT NULL,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // Create tests table
      await conn.query('''
        CREATE TABLE IF NOT EXISTS tests (
          id INT AUTO_INCREMENT PRIMARY KEY,
          imagePath TEXT NOT NULL,
          result VARCHAR(50) NOT NULL,
          confidence DECIMAL(5,4) NOT NULL,
          userId INT NOT NULL,
          createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
          INDEX idx_tests_user_id (userId),
          INDEX idx_tests_created_at (createdAt)
        )
      ''');
      
      print('Database tables initialized successfully');
    } catch (e) {
      print('Error initializing database tables: $e');
      rethrow;
    }
  }

  // User operations
  Future<int> insertUser(User user) async {
    final conn = await connection;
    final result = await conn.query(
      'INSERT INTO users (name, lastName, age) VALUES (?, ?, ?)',
      [user.name, user.lastName, user.age],
    );
    return result.insertId!;
  }

  Future<List<User>> getAllUsers() async {
    final conn = await connection;
    final results = await conn.query('SELECT * FROM users ORDER BY created_at DESC');
    return results.map((row) => User.fromMap(row.fields)).toList();
  }

  Future<User?> getUserById(int id) async {
    final conn = await connection;
    final results = await conn.query(
      'SELECT * FROM users WHERE id = ?',
      [id],
    );
    if (results.isNotEmpty) {
      return User.fromMap(results.first.fields);
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    final conn = await connection;
    final result = await conn.query(
      'UPDATE users SET name = ?, lastName = ?, age = ? WHERE id = ?',
      [user.name, user.lastName, user.age, user.id],
    );
    return result.affectedRows!;
  }

  Future<int> deleteUser(int id) async {
    final conn = await connection;
    final result = await conn.query(
      'DELETE FROM users WHERE id = ?',
      [id],
    );
    return result.affectedRows!;
  }

  // Test operations
  Future<int> insertTest(Test test) async {
    final conn = await connection;
    final result = await conn.query(
      'INSERT INTO tests (imagePath, result, confidence, userId) VALUES (?, ?, ?, ?)',
      [test.imagePath, test.result, test.confidence, test.userId],
    );
    return result.insertId!;
  }

  Future<List<Test>> getAllTests() async {
    final conn = await connection;
    final results = await conn.query('SELECT * FROM tests ORDER BY createdAt DESC');
    return results.map((row) => Test.fromMap(row.fields)).toList();
  }

  Future<List<Test>> getTestsByUserId(int userId) async {
    final conn = await connection;
    final results = await conn.query(
      'SELECT * FROM tests WHERE userId = ? ORDER BY createdAt DESC',
      [userId],
    );
    return results.map((row) => Test.fromMap(row.fields)).toList();
  }

  Future<Test?> getTestById(int id) async {
    final conn = await connection;
    final results = await conn.query(
      'SELECT * FROM tests WHERE id = ?',
      [id],
    );
    if (results.isNotEmpty) {
      return Test.fromMap(results.first.fields);
    }
    return null;
  }

  Future<int> updateTest(Test test) async {
    final conn = await connection;
    final result = await conn.query(
      'UPDATE tests SET imagePath = ?, result = ?, confidence = ?, userId = ? WHERE id = ?',
      [test.imagePath, test.result, test.confidence, test.userId, test.id],
    );
    return result.affectedRows!;
  }

  Future<int> deleteTest(int id) async {
    final conn = await connection;
    final result = await conn.query(
      'DELETE FROM tests WHERE id = ?',
      [id],
    );
    return result.affectedRows!;
  }

  // Combined operations
  Future<List<Map<String, dynamic>>> getTestsWithUserInfo() async {
    final conn = await connection;
    final results = await conn.query('''
      SELECT 
        t.id,
        t.imagePath,
        t.result,
        t.confidence,
        t.createdAt,
        u.id as userId,
        u.name,
        u.lastName,
        u.age
      FROM tests t
      INNER JOIN users u ON t.userId = u.id
      ORDER BY t.createdAt DESC
    ''');
    
    return results.map((row) {
      final fields = row.fields;
      return {
        'id': fields['id'],
        'imagePath': fields['imagePath'],
        'result': fields['result'],
        'confidence': fields['confidence'],
        'createdAt': fields['createdAt'],
        'userId': fields['userId'],
        'name': fields['name'],
        'lastName': fields['lastName'],
        'age': fields['age'],
      };
    }).toList();
  }

  Future<Map<String, dynamic>?> getTestWithUserInfo(int testId) async {
    final conn = await connection;
    final results = await conn.query('''
      SELECT 
        t.id,
        t.imagePath,
        t.result,
        t.confidence,
        t.createdAt,
        u.id as userId,
        u.name,
        u.lastName,
        u.age
      FROM tests t
      INNER JOIN users u ON t.userId = u.id
      WHERE t.id = ?
    ''', [testId]);
    
    if (results.isNotEmpty) {
      final fields = results.first.fields;
      return {
        'id': fields['id'],
        'imagePath': fields['imagePath'],
        'result': fields['result'],
        'confidence': fields['confidence'],
        'createdAt': fields['createdAt'],
        'userId': fields['userId'],
        'name': fields['name'],
        'lastName': fields['lastName'],
        'age': fields['age'],
      };
    }
    return null;
  }

  // Statistics operations
  Future<Map<String, dynamic>> getTestStatistics() async {
    final conn = await connection;
    
    // Total tests
    final totalResults = await conn.query('SELECT COUNT(*) as total FROM tests');
    final totalTests = totalResults.first.fields['total'] as int;

    // Tests by result
    final resultStats = await conn.query('''
      SELECT result, COUNT(*) as count
      FROM tests
      GROUP BY result
    ''');

    // Recent tests (last 30 days)
    final recentResults = await conn.query('''
      SELECT COUNT(*) as recent
      FROM tests 
      WHERE createdAt >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    ''');
    final recentTests = recentResults.first.fields['recent'] as int;

    return {
      'totalTests': totalTests,
      'resultStats': resultStats.map((row) => row.fields).toList(),
      'recentTests': recentTests,
    };
  }

  // Database maintenance
  Future<void> closeConnection() async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
    }
  }

  // Test database connection
  Future<bool> testConnection() async {
    try {
      final conn = await connection;
      await conn.query('SELECT 1');
      return true;
    } catch (e) {
      print('Database connection test failed: $e');
      return false;
    }
  }
}
