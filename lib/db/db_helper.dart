import 'package:flutter/material.dart';
import 'package:flutter_product_app/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
class DBSQLiteHelper{
  static final String _CREATE_TABLE_PRODUCT ='''create table $TABLE_PRODUCT(
    $COL_PRODUCT_ID integer primary key autoincrement,
    $COL_PRODUCT_NAME text not null,
    $COL_PRODUCT_DESCRIPTION text not null,
    $COL_PRODUCT_CATEGORY text not null,
    $COL_PRODUCT_FORMATTED_DATE text not null,
    $COL_PRODUCT_PRICE real not null,
    $COL_PRODUCT_RATING real not null,
    $COL_PRODUCT_TIMESTAMP integer not null,
    $COL_PRODUCT_MONTH integer not null,
    $COL_PRODUCT_YEAR integer not null,
    $COL_PRODUCT_FAV integer not null,
    $COL_PRODUCT_IMAGE text not null)''';
  static Future<Database> _open() async{
    final root = await getDatabasesPath();
    final dbPath = Path.join(root,'product.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) async{
     await db.execute(_CREATE_TABLE_PRODUCT);
    });
  }

  static Future<int> insertNewProduct(Product product)  async{
    final db = await _open();
    return db.insert(TABLE_PRODUCT, product.toMap());

  }
  static Future<List<Map<String,dynamic>>> getAllProducts()  async{
    final db = await _open();
    return db.query(TABLE_PRODUCT);
  }
  static Future<int> deleteProduct(int id)  async {
    final db = await _open();
    return db.delete(
        TABLE_PRODUCT, where: '$COL_PRODUCT_ID=?', whereArgs: [id]);
  }
}