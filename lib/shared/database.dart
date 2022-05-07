import 'package:flutter/cupertino.dart';
import 'package:myfarm/modal/farm.dart';
import 'package:myfarm/modal/table.dart';
import 'package:sqflite/sqflite.dart';

import '../modal/tree.dart';

class MyDatabase {
  Database myDatabase;

  Future<void> openMyDatabase() async {
    myDatabase = await openDatabase('myfarm.db', version: 1,
        onCreate: (database, version) async {
      print('database Created');
      await database
          .execute(
              'CREATE TABLE Farm (id INTEGER PRIMARY KEY, name TEXT, numH INTEGER, numW INTEGER)')
          .then((value) {
        print('Farm table created ');
      });
      await database
          .execute(
              'CREATE TABLE Tree (id INTEGER PRIMARY KEY, indexW INTEGER,indexH INTEGER, type TEXT, note TEXT, farmId INTEGER)')
          .then((value) {
        print('Tree table created ');
      });
      await database
          .execute(
              'CREATE TABLE Activity (id INTEGER PRIMARY KEY, name TEXT,actDate TEXT, cost REAL, type INTEGER, note TEXT, farmId INTEGER)')
          .then((value) {
        print('Activity table created ');
      });
    }, onOpen: (database) {
      print('database opened');
    });
  }

  Future<void> insertToMyDatabase(Tables tables) async {

    int id = await myDatabase.insert(tables.tableName, tables.toMap());
    print('the $id \'s ${tables.tableName} with the values ${tables.toMap()}');
    if (tables is Farm) {
      for (int i = 0; i < tables.numW; i++) {
        for (int j = 0; j < tables.numH; j++) {
          Tree t =
              new Tree(type: '', indexH: j, indexW: i, note: '', farmId: id);
          await insertToMyDatabase(t);
        }
      }
    }
  }

  Future<List<Map>> getFarmsData() async {
    List<Map> maps = await myDatabase.query('Farm');
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<List<Map>> getActivitiesData({@required int farmId}) async {
    List<Map> maps = await myDatabase
        .query('Activity', where: 'farmId = ?', whereArgs: [farmId]);
    print('getted data');
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<List<Map>> getTreesData({@required int farmId}) async {
    List<Map> maps = await myDatabase
        .query('Tree', where: 'farmId = ?', whereArgs: [farmId]);
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  Future<void> updateMyDatabase(Tables tables, int id) async {
    /* if (tables is Farm) {
      for (int i = 1; i <= tables.numW; i++) {
        for (int j = 1; j <= tables.numH; j++) {
          Tree t = new Tree(
              type: '', indexH: j, indexW: i, note: '', farmId: tables.id);
          await insetToMyDatabase(t);
        }
      }
    }*/
    await myDatabase.update(tables.tableName, tables.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteFromMyDatabase(Tables tables, int id) async {
    var cnt;
    if (tables is Farm) {
      cnt =
          await myDatabase.delete('Tree', where: 'farmId = ?', whereArgs: [id]);
      print('$cnt deleted from Tree Table ');
      cnt = await myDatabase
          .delete('Activity', where: 'farmId = ?', whereArgs: [id]);
      print('$cnt deleted from Activity Table ');
    }
    cnt = await myDatabase
        .delete(tables.tableName, where: 'id = ?', whereArgs: [id]);
    print('$cnt deleted from ${tables.tableName} Table ');
  }

  Future<void> close() async {
    myDatabase.close().then((value) => (print('MyDatabase Closed')));
  }

  Future<void> doSomething() async {}
}
