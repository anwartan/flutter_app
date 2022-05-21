import 'dart:async';

import 'package:core/data/models/watch_table.dart';
import 'package:core/utils/enum.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        refId INTEGER,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        type TINYINT
      );
    ''');
  }

  Future<int> insertWatchlist(WatchTable watch) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, watch.toJson());
  }

  Future<int> removeWatchlist(WatchTable watch) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'refId = ? and type = ?',
      whereArgs: [watch.refId, watch.type.index],
    );
  }

  // Future<Map<String, dynamic>?> getWatchById(int id) async {
  //   final db = await database;
  //   final results = await db!.query(
  //     _tblWatchlist,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  //
  //   if (results.isNotEmpty) {
  //     return results.first;
  //   } else {
  //     return null;
  //   }
  // }

  Future<List<Map<String, dynamic>>> getWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  Future<Map<String, dynamic>?> getWatchByRefIdAndType(
      int refId, Type type) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'refId = ? and type = ?',
      whereArgs: [refId, type.index],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
