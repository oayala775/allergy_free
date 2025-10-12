import 'package:allergy_free/models/avatar.dart';

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

  Future<User?> verifyIfUserExist(String username) async {
    final db = await _databaseHelper.database;

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username],
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

  Future<int?> register(User user) async {
    final db = await _databaseHelper.database;

    try {
      final int result = await db.insert('users', user.toMap());

      return result;
    } catch (e) {
      print('Error en login: $e');
      return null;
    }
  }

  Future<Avatar?> retrieveAvatarID(String avatarPath) async {
    final db = await _databaseHelper.database;

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'avatars',
        where: 'avatar_path = ?',
        whereArgs: [avatarPath],
      );

      if (maps.isNotEmpty) {
        return Avatar.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Error en login: $e');
      return null;
    }
  }
}
