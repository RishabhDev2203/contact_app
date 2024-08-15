import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../dto/contact_dto.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  static Database? _database;

  factory DatabaseManager() => _instance;

  DatabaseManager._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phoneNumber TEXT,
            email TEXT,
            imagePath TEXT,
            isFavorite INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<int> insertContact(ContactDto contact) async {
    final db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<List<ContactDto>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (i) {
      return ContactDto.fromMap(maps[i]);
    });
  }

  Future<int> updateContact(ContactDto contact) async {
    final db = await database;
    return await db.update('contacts', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavoriteContacts() async {
    Database db = await database;
    return await db.query('contacts', where: 'isFavorite = ?', whereArgs: [1]);
  }
}
