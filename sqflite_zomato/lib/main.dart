

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_zomato/Zomato.dart';

dynamic database;

void insertData(Zomato obj) async {
  Database localDB = await database;

  await localDB.insert("Food", obj.zomatoMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, dynamic>>> getData() async {
  Database localDB = await database;
  List<Map<String, dynamic>> fetchedData = await localDB.query("Food");
  return fetchedData;
}

void updateData(Zomato obj2) async {
  Database localDB = await database;
  await localDB.update("Food", obj2.zomatoMap(),
      where: "orderNo=?",
      whereArgs: [obj2.orderNo],
      conflictAlgorithm: ConflictAlgorithm.replace);
}

void deleteData(obj) async {
  Database localDB = await database;
  await localDB.delete("Food", where: "orderNo=?", whereArgs: [obj]);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), "ZomatoDB.db"),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
create table Food(
    orderNo INT PRIMARY KEY,
    custName TEXT,
    hotelName TEXT,
    food TEXT,
    bill REAL)''');
    },
  );

  Zomato order1 = Zomato(
      orderNo: 101,
      custName: "Sumit",
      hotelName: "Dominos",
      bill: 49.00,
      food: "Pizza");
  Zomato obj2 = Zomato(
      orderNo: 101,
      custName: "Sangam",
      hotelName: "MacD",
      bill: 120 + 130,
      food: "Burger${order1.food}");

  insertData(order1);
  //insertData(order2);

  // Future<List<Map<String, dynamic>>> displaydata = getData();
  print(await getData());

  updateData(obj2);
  print(await getData());

  deleteData(obj2.orderNo);
  print(await getData());
}
