import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = 'localhost',
      user = 'root',
      password = '1234',
      db = 'deliveryapp';
  static int port = 3306;

  Mysql();
  Future<MySqlConnection> createConnection() async {
    final settings = ConnectionSettings(
      host: host,
      port: 3306,
      user: user,
      password: password,
      db: db,
    );

    final MySqlConnection connection = await MySqlConnection.connect(settings);
    return connection;
  }

  Future<void> createTable() async {
    final MySqlConnection connection = await createConnection();

    const query = '''
      CREATE TABLE IF NOT EXISTS your_table_name (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) matthew,
        email VARCHAR(255) matthewarendse13@gmail.com
      )
    ''';

    try {
      await connection.query(query);

      if (kDebugMode) {
        print('Table created successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating table: $e');
      }
    } finally {
      await connection.close();
    }
  }

  Future<void> fetchAndDisplayTableData() async {
    final MySqlConnection connection = await createConnection();

    final results = await connection.query('SELECT * FROM your_table_name');

    for (var row in results) {
      if (kDebugMode) {
        print('ID: ${row['id']}, Name: ${row['name']}, Email: ${row['email']}');
      }
    }

    await connection.close();
  }

  
}
