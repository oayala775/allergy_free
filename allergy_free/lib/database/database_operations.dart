import 'package:allergy_free/models/allergy.dart';
import 'package:allergy_free/models/avatar.dart';
import 'package:allergy_free/models/ingredient.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<int?> insertUser(User user) async {
    final db = await _databaseHelper.database;

    try {
      final int result = await db.insert('users', user.toMap());

      return result;
    } catch (e) {
      print('Error en login: $e');
      return null;
    }
  }

  Future<int?> updateUser(User user) async {
    final db = await _databaseHelper.database;

    try {
      final int result = await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );

      return result;
    } catch (e) {
      print('Error en login: $e');
      return null;
    }
  }
  // Future<int?> insertAllergyList(int userId, int allergyId) async {
  //   final db = await _databaseHelper.database;

  //   try {
  //     final int result = await db.insert('allergies', user.toMap());

  //     return result;
  //   } catch (e) {
  //     print('Error en login: $e');
  //     return null;
  //   }
  // }

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

  Future<Avatar?> retrieveAvatar(String avatarID) async {
    final db = await _databaseHelper.database;

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'avatars',
        where: 'id = ?',
        whereArgs: [avatarID],
      );
      return Avatar.fromMap(maps.first);
    } catch (e) {
      print('Error al obtener un avatar $e');
    }
  }

  Future<List<Allergy>> getSystemAllergies() async {
    final db = await _databaseHelper.database;

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'allergies',
        orderBy: 'allergy_name ASC',
      );
      return List.generate(maps.length, (i) {
        return Allergy.fromMap(maps[i]);
      });
    } catch (e) {
      print("Error al obtener alergias: $e");
      return [];
    }
  }

  Future<int?> insertAllergy(Allergy allergy) async {
    final db = await _databaseHelper.database;
    try {
      final int newId = await db.insert(
        'allergies',
        allergy.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return newId;
    } catch (e) {
      print("Error en insertAllergy: $e");
      return null;
    }
  }

  Future<void> insertUserAllergy(int userId, int allergyId) async {
    final db = await _databaseHelper.database;
    try {
      await db.insert('user_allergies', {
        'user_id': userId,
        'allergy_id': allergyId,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      print("Error en insertUserAllergy: $e");
    }
  }

  Future<List<Allergy>> getUserAllergies(int userId) async {
    final db = await _databaseHelper.database;

    try {
      final String sql = '''
      SELECT a.* FROM user_allergies ua
      JOIN allergies a ON ua.allergy_id = a.id
      WHERE ua.user_id = ?
    ''';

      final List<Map<String, dynamic>> maps = await db.rawQuery(sql, [userId]);

      return List.generate(maps.length, (i) {
        return Allergy.fromMap(maps[i]);
      });
    } catch (e) {
      print("Error en getUserAllergies: $e");
      return []; // Devuelve una lista vacía si hay un error
    }
  }

  Future<List<Ingredient>> getIngredientsForAllergy(int allergyId) async {
    final db = await _databaseHelper.database;
    try {
      final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''
      SELECT T2.* FROM allergy_ingredients AS T1
      JOIN ingredients AS T2 ON T1.ingredient_id = T2.id
      WHERE T1.allergy_id = ?
    ''',
        [allergyId],
      );

      return List.generate(maps.length, (i) {
        return Ingredient.fromMap(maps[i]);
      });
    } catch (e) {
      print("Error en getIngredientsForAllergy: $e");
      return [];
    }
  }
}
