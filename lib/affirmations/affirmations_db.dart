import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AffirmationDatabase {
  static final AffirmationDatabase instance = AffirmationDatabase._init();

  static Database? _database;

  AffirmationDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('affirmations.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE affirmations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertAffirmation(String affirmation) async {
    final db = await database;
    return await db.insert(
      'affirmations',
      {'text': affirmation},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getAffirmations() async {
    final db = await database;
    final result = await db.query('affirmations');

    return result.map((row) => row['text'] as String).toList();
  }

  Future<void> deleteAllAffirmations() async {
    final db = await database;
    await db.delete('affirmations');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
