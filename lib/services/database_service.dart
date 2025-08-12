import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/test.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'oculocheck.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tests (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imagePath TEXT NOT NULL,
            result TEXT NOT NULL,
            confidence REAL NOT NULL,
            name TEXT NOT NULL,
            lastName TEXT NOT NULL,
            age INTEGER NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> initializeDatabase() async {
    await database;
  }

  Future<int> insertTest(Test test) async {
    final db = await database;
    return await db.insert('tests', test.toMap());
  }

  Future<List<Test>> getAllTests() async {
    final db = await database;
    final rows = await db.query('tests', orderBy: 'datetime(createdAt) DESC');
    return rows.map((m) => Test.fromMap(m)).toList();
  }

  Future<Test?> getTestById(int id) async {
    final db = await database;
    final rows = await db.query('tests', where: 'id = ?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return Test.fromMap(rows.first);
  }

  Future<int> updateTest(Test test) async {
    final db = await database;
    return await db.update('tests', test.toMap(), where: 'id = ?', whereArgs: [test.id]);
  }

  Future<int> deleteTest(int id) async {
    final db = await database;
    return await db.delete('tests', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getTestsWithUserInfo() async {
    final db = await database;
    final rows = await db.query('tests', orderBy: 'datetime(createdAt) DESC');
    return rows.map((m) => {
          'id': m['id'],
          'imagePath': m['imagePath'],
          'result': m['result'],
          'confidence': m['confidence'] is num ? (m['confidence'] as num).toDouble() : m['confidence'],
          'createdAt': m['createdAt'],
          'name': m['name'],
          'lastName': m['lastName'],
          'age': m['age'],
        }).toList();
  }

  Future<Map<String, dynamic>> getTestStatistics() async {
    final db = await database;
    final total = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM tests')) ?? 0;
    final resultStats = await db.rawQuery('SELECT result, COUNT(*) as count FROM tests GROUP BY result');
    final recent = Sqflite.firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM tests WHERE datetime(createdAt) >= datetime('now','-30 days')")) ??
        0;
    return {
      'totalTests': total,
      'resultStats': resultStats,
      'recentTests': recent,
    };
  }

  Future<void> closeConnection() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  Future<List<Map<String, dynamic>>> dumpAll() async {
    final db = await database;
    return await db.query('tests');
  }
}
