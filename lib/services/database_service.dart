import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:sqflite_sqlcipher/sqflite.dart' as sqlcipher;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseService {

  static dynamic _database;

  static const _dbName = "equifood.db";
  static const _password = "equifood_secure_key_2024";

  /// IMPORTANTE
  /// Incrementa este número cuando cambies foods.json
  static const _foodsDataVersion = 3;

  static Future<dynamic> getDatabase() async {

    if (_database != null) {
      return _database;
    }

    if (Platform.isWindows) {

      sqfliteFfiInit();

      final databaseFactory = databaseFactoryFfi;

      final dbPath = await databaseFactory.getDatabasesPath();
      final path = join(dbPath, _dbName);

      _database = await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _createDatabase,
          onOpen: _checkDatabaseState,
        ),
      );

    } else {

      final dbPath = await sqlcipher.getDatabasesPath();
      final path = join(dbPath, _dbName);

      _database = await sqlcipher.openDatabase(
        path,
        password: _password,
        version: 1,
        onCreate: _createDatabase,
        onOpen: _checkDatabaseState,
      );

    }

    return _database;
  }

  static Future<void> _createDatabase(dynamic db, int version) async {

    await db.execute('''
      CREATE TABLE foods(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        grams INTEGER,
        category TEXT,
        group_name TEXT
      )
    ''');

    await db.execute(
      "CREATE INDEX idx_food_name ON foods(name)"
    );

    /// tabla para guardar metadatos
    await db.execute('''
      CREATE TABLE app_metadata(
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');

    await _importFoodsFromJson(db);

    await _saveFoodsVersion(db);
  }

  static Future<void> _checkDatabaseState(dynamic db) async {

    /// comprobar si la tabla metadata existe
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='app_metadata'"
    );

    if (tables.isEmpty) {
      await db.execute('''
        CREATE TABLE app_metadata(
          key TEXT PRIMARY KEY,
          value TEXT
        )
      ''');

      await _importFoodsFromJson(db);
      await _saveFoodsVersion(db);
      return;
    }

    final storedVersion = await _getStoredFoodsVersion(db);

    /// si la versión de datos ha cambiado → actualizar alimentos
    if (storedVersion != _foodsDataVersion) {

      await db.delete('foods');

      await _importFoodsFromJson(db);

      await _saveFoodsVersion(db);
    }

    /// reparación básica
    final result = await db.rawQuery("SELECT COUNT(*) as count FROM foods");

    final count = result.first["count"] as int;

    if (count == 0) {
      await _importFoodsFromJson(db);
      await _saveFoodsVersion(db);
    }
  }

  static Future<int?> _getStoredFoodsVersion(dynamic db) async {

    final result = await db.query(
      'app_metadata',
      where: 'key = ?',
      whereArgs: ['foods_data_version'],
    );

    if (result.isEmpty) {
      return null;
    }

    return int.tryParse(result.first['value']);
  }

  static Future<void> _saveFoodsVersion(dynamic db) async {

    await db.insert(
      'app_metadata',
      {
        'key': 'foods_data_version',
        'value': _foodsDataVersion.toString()
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> _importFoodsFromJson(dynamic db) async {

    final jsonString = await rootBundle.loadString('assets/data/foods.json');
    final decoded = json.decode(jsonString);

    List<dynamic> foodsList;

    if (decoded is List) {
      foodsList = decoded;
    } else if (decoded is Map && decoded.containsKey('foods')) {
      foodsList = decoded['foods'];
    } else {
      throw Exception("Invalid foods.json structure");
    }

    final batch = db.batch();

    for (var item in foodsList) {
      batch.insert('foods', {
        'name': item['name'],
        'grams': item['grams'],
        'category': item['category'],
        'group_name': item['group'],
      });
    }

    await batch.commit(noResult: true);
  }
}