import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelperFile {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'file.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE file(id TEXT PRIMARY KEY, number TEXT, name TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelperFile.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelperFile.database();
    return db.query(table);
  }

  static Future<int> delete(String id) async {
    final db = await DBHelperFile.database();

    return await db.delete(
      'file',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
