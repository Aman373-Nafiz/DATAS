import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/users.dart';
class Databasehelper {
Database? _database;
 Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user_data.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, phone TEXT, address TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }
   Future<void> insertUser(Users users) async {
      if (_database == null) await initializeDatabase();
      await _database!.insert(
      'users',users.toJson(),
     
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Map<String, dynamic>>> _fetchUserData() async {
      if (_database == null) await initializeDatabase();
    return await _database!.query('users');
  }
  Future<Map<String, dynamic>?> getUser(String email, String password) async {
      if (_database == null) await initializeDatabase();
    final db = await _database;
    final result = await db!.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? result.first : null;
  }
}