import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wordle_app/models/user.dart';

class AcountProvider extends ChangeNotifier {
  String nickname = '';
  String password = '';
  late User? userGame;
  bool isLoading = true;

  bool createUser() {
    if (nickname == '' || password == '') return false;
    User user = User(nickname: nickname, password: password);
    insertUser(user);
    nickname = '';
    password = '';
    return true;
  }

  Future<Database> database() async {
    final String path = join(await getDatabasesPath(), 'wordle_app.db');
    final opendatabse = openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user(id Integer PRIMARY KEY, nickname TEXT, password TEXT, bestTry Integer, numTries Integer, bestTime Integer, numTries2 Integer)',
      );
    }, version: 1);

    return opendatabse;
  }

  Future<void> insertUser(User user) async {
    final Database db = await database();
    await db.insert('user', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  Future<void> selectedUser() async {
    isLoading = true;
    final Database db = await database();
    final List<Map<String, dynamic>> maps = await db.query('user', limit: 1);
    maps.isEmpty ? userGame = null : userGame = User.fromMap(maps.first);
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    final Database db = await database();
    await db.update('user', user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  Future<void> deleteUser(User user) async {
    final Database db = await database();
    await db.delete('user', where: 'id = ?', whereArgs: [user.id]);
    notifyListeners();
  }
}
