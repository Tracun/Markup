import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:calcular_preco_venda/objects/Product.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider();

  static final DBProvider dbProvider = DBProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Product.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Product ("
          "id INTEGER PRIMARY KEY,"
          "nome TEXT,"
          "custo REAL,"
          "encargo REAL,"
          "comissao REAL,"
          "lucro REAL,"
          "outros REAL,"
          "imp1 REAL,"
          "imp2 REAL,"
          "custoIndireto REAL,"
          "precoFora REAL,"
          "precoDentro REAL,"
          "uriImg TEXT"
          ")");
    });
  }
}
