import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// AppDatabase — Manages local SQLite schema, migrations, and CRUD helpers.
class AppDatabase {
  static const String _dbName = 'nenil.db';
  static const int _dbVersion = 1;

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    debugPrint('[AppDatabase] Initializing SQLite database schema v$version...');

    // 1. Patients Table
    await db.execute('''
      CREATE TABLE patients (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        stage TEXT NOT NULL DEFAULT 'mild',
        preferred_language TEXT NOT NULL DEFAULT 'en',
        avatar_url TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // 2. Caregivers Table
    await db.execute('''
      CREATE TABLE caregivers (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        relationship TEXT NOT NULL,
        pin_hash TEXT NOT NULL,
        patient_id TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE SET NULL
      )
    ''');

    // 3. Game Sessions Table
    await db.execute('''
      CREATE TABLE sessions (
        id TEXT PRIMARY KEY,
        patient_id TEXT NOT NULL,
        game_type TEXT NOT NULL,
        duration_seconds INTEGER NOT NULL,
        engagement_score REAL NOT NULL,
        completed_at TEXT NOT NULL,
        is_synced INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
      )
    ''');

    // 4. Daily Routines Table
    await db.execute('''
      CREATE TABLE routines (
        id TEXT PRIMARY KEY,
        patient_id TEXT NOT NULL,
        title TEXT NOT NULL,
        time_of_day TEXT NOT NULL,
        audio_prompt_path TEXT,
        icon_name TEXT,
        is_completed INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
      )
    ''');

    debugPrint('[AppDatabase] SQLite schema creation complete.');
  }

  static Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
