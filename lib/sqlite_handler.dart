library sqlite_handler;

import 'database/database_helper.dart';
export 'core/enums/sqlite_data_type.dart';


abstract class Model extends DBHelper {
  Model(String table, Map fields) : super(table, fields);

  fromMap(Map<String, dynamic> json);

  @override
  Map<String, Object?> toMap();
}
