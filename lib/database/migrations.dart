import '/core/extensions/string.dart';

import '../core/enums/sqlite_data_type.dart';

class Migrations {
  String statement = "";
  late String tableName;

  late Map columns = <String, SqlTypes>{};

  Migrations(this.tableName, this.columns) {
    _handle();
  }

  void _handle() {
    var query = 'CREATE TABLE $tableName (';
    columns.forEach((key, value) {
      if (key == 'id') {
        query += ' $key ${getType(value)} PRIMARY KEY AUTOINCREMENT, ';
      } else {
        query += '$key ${getType(value)} ,';
      }
    });
    statement = '${query.removeLastCharacter(count: 1)})';
  }

  String getType(SqlTypes sqlTypes) =>
      sqlTypes.toString().split(".")[1].toUpperCase();
}
