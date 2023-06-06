class SqlQueries {
  static String createTable() {
    return '''
          CREATE TABLE 'notes' (
          'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          'title' TEXT NOT NULL,
          'topic' TEXT NOT NULL
          )
    ''';
  }

  static String readDataSql() {
    return '''
          SELECT * FROM 'notes'
  ''';
  }

  static String insertDataSql(String title, String topic) {
    return '''
           INSERT INTO 'notes' ('title', 'topic') 
           VALUES ('$title', '$topic')
    ''';
  }

  static String updateDataSql(String id, String columnName, String newValue) {
    return '''
          UPDATE 'notes'
          SET '$columnName' = '$newValue'
          WHERE 'id' = '$id'
    ''';
  }

  static String deleteDataSql(String id) {
    return '''
           DELETE FROM 'notes'
           WHERE 'id' = '$id'
    ''';
  }
}
