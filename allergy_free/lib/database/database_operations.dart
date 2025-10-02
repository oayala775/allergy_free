import 'database_helper.dart';
import '../models/user.dart';

class DatabaseOperations {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<User?> login(String username, String password) async {
    final db = await _databaseHelper.database;

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );

      if (maps.isNotEmpty) {
        return User.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Error en login: $e');
      return null;
    }
  }
}
