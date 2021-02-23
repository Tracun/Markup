import 'dart:developer';

import 'package:calcular_preco_venda/objects/Product.dart';
import 'package:calcular_preco_venda/services/DB/Database.dart';

class ProductDAO{

    final dbProvider = DBProvider.dbProvider;
  
    Future<dynamic> newProduct(Product newProduct) async {
    final db = await dbProvider.database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Product");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Product (id, nome, custo, encargo, comissao, lucro, outros, imp1, imp2, custoIndireto, precoFora, precoDentro, uriImg)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newProduct.nome,
          newProduct.custo,
          newProduct.encargo,
          newProduct.comissao,
          newProduct.lucro,
          newProduct.outros,
          newProduct.imp1,
          newProduct.imp2,
          newProduct.custoIndireto,
          newProduct.precoFora,
          newProduct.precoDentro,
          newProduct.uriImg
        ]);

    log("INSERÇÃO PRODUTO: $raw");
    return raw;
  }

  updateProduct(Product newProduct) async {
    final db = await dbProvider.database;
    var res = await db.update("Product", newProduct.toMap(),
        where: "id = ?", whereArgs: [newProduct.id]);
    return res;
  }

  getProduct(int id) async {
    final db = await dbProvider.database;
    var res = await db.query("Product", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Product.fromMap(res.first) : null;
  }

  Future<List<Product>> getAllProduct() async {
    final db = await dbProvider.database;
    var res = await db.query("Product");
    List<Product> list =
        res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    return list;
  }

  deleteProduct(int id) async {
    final db = await dbProvider.database;
    return db.delete("Product", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await dbProvider.database;
    db.rawDelete("Delete * from Product");
  }
}