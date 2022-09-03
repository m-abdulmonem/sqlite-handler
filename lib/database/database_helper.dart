import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'migrations.dart';

abstract class DBHelper extends Migrations {
  String table = "";

  DBHelper(this.table, Map fields) : super(table, fields);

  Future<Database> get database async {
    var path = join(await getDatabasesPath(), '${table}_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) => db.execute(statement),
      version: 1,
    );
  }

  Future<String> get path async =>
      join(await getDatabasesPath(), '${table}_database.db');

  Future? rawQuery(String query) async {
    Database db = await database;

    return await db.rawQuery(query);
  }

  Future<Map<String, Object?>?> getItem(int id) async {
    Database db = await database;

    List<Map<String, Object?>> result =
        await db.rawQuery("SELECT * FROM $table WHERE id = $id");

    if (result.isEmpty) return null;

    return result.first;
  }

  Future<int> insert() async {
    Database db = await database;

    return await db.insert(
      table,
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List> get() async{
    Database db = await database;

    return await db.query(table);
  }
  Future update(id) async {
    final db = await database;

    return await db.update(
      table,
      toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> erase() async {
    final db = await database;

    var data = await get();

    for (Map model in data) {
      await db.delete(
        table,
        where: 'id = ?',
        whereArgs: [model['id']],
      );
    }
  }

  Map<String, Object?> toMap();
}
