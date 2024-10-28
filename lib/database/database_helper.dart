import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'elibrary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT
      )
    ''');
  }

  Future<int> insertUser(String email, String password) async {
    Database db = await database;
    return await db.insert('users', {
      'email': email,
      'password': password,
    });
  }

  Future<bool> checkUser(String email, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return users.isNotEmpty;
  }

  Future<bool> emailExists(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return users.isNotEmpty;
  }

  Future<Map<String, dynamic>> getUserData(String email) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (results.isNotEmpty) {
      return results.first;
    }
    return {};
  }
}
