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

    debugPrint('[AppDatabase] SQLite schema creation complete. Inserting SIH 2026 Hackathon seed data...');

    // Seed Demo Patient Profile
    await db.insert('patients', {
      'id': 'patient-sih-1',
      'name': 'Aideo Boro',
      'stage': 'mild',
      'preferred_language': 'as',
      'avatar_url': null,
      'created_at': DateTime.now().toIso8601String(),
    });

    // Seed Demo Caregiver Profile (PIN: 1234)
    await db.insert('caregivers', {
      'id': 'caregiver-sih-1',
      'name': 'Rahul Boro',
      'phone': '+91 98765 43210',
      'relationship': 'Son',
      'pin_hash': '1234',
      'patient_id': 'patient-sih-1',
      'created_at': DateTime.now().toIso8601String(),
    });

    // Seed Demo Past Game Sessions
    await db.insert('sessions', {
      'id': 'sess-1',
      'patient_id': 'patient-sih-1',
      'game_type': 'daily_routine',
      'duration_seconds': 180,
      'engagement_score': 9.2,
      'completed_at': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      'is_synced': 1,
    });
    await db.insert('sessions', {
      'id': 'sess-2',
      'patient_id': 'patient-sih-1',
      'game_type': 'music_memory',
      'duration_seconds': 240,
      'engagement_score': 9.8,
      'completed_at': DateTime.now().subtract(const Duration(hours: 4)).toIso8601String(),
      'is_synced': 0,
    });
    await db.insert('sessions', {
      'id': 'sess-3',
      'patient_id': 'patient-sih-1',
      'game_type': 'family_faces',
      'duration_seconds': 150,
      'engagement_score': 8.9,
      'completed_at': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
      'is_synced': 0,
    });

    // Seed Demo Daily Routines
    await db.insert('routines', {
      'id': 'rout-1',
      'patient_id': 'patient-sih-1',
      'title': 'Morning Assam Tea',
      'time_of_day': 'Morning',
      'audio_prompt_path': null,
      'icon_name': 'local_cafe_rounded',
      'is_completed': 1,
    });
    await db.insert('routines', {
      'id': 'rout-2',
      'patient_id': 'patient-sih-1',
      'title': 'Water the Garden Plants',
      'time_of_day': 'Afternoon',
      'audio_prompt_path': null,
      'icon_name': 'eco_rounded',
      'is_completed': 0,
    });

    debugPrint('[AppDatabase] SIH 2026 Seed data inserted successfully.');
  }

  static Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
