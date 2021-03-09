import 'dart:io';

import 'package:my_flutter_delivery_app/Models/Livreur.dart';
import 'package:my_flutter_delivery_app/Models/Order.dart';
import 'package:my_flutter_delivery_app/Models/Receptionnaire.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  final String tableLivraison = 'tableLivraison';
  final String tableReceptionnaire = 'tableReceptionnaire';
  final String tableLivreur = 'tableLivreur';
  final String columnId = '_id';
  final String columnNomProduit = 'nomProduit';
  final String columnNomPrenoms = 'nomPrenoms';
  final String columnTel = 'tel';
  final String columnCoutTotal = 'coutTotal';
  final String columnEtatLivraison = 'etatLivraison';
  final String columnLogin = 'login';
  final String columnPassword = 'password';
  static final DatabaseProvider _instance = new DatabaseProvider.internal();
  factory DatabaseProvider() => _instance;
  Database _db;
  DatabaseProvider.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await create();

    return _db;
  }

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String _dbPath = join(path.path, "topFood._db");

    _db = await openDatabase(_dbPath, version: 1, onCreate: this._create);
  }

  Future _create(Database _db, int version) async {
    await _db.execute("""
            create table $tableReceptionnaire ($columnId integer primary key, $columnNomPrenoms text not null, $columnTel text not null)""");
    await _db.execute("""
            create table $tableLivreur ($columnId integer primary key, $columnLogin text not null, $columnPassword text not null)""");
    await _db.execute("""
            create table $tableLivraison ($columnId integer primary key, $columnNomPrenoms text not null, $columnNomProduit text not null, $columnEtatLivraison text not null, $columnTel text not null, $columnCoutTotal integer)""");
  }

  Future insertLivreur(Livreur livreur) async {
    List<Map> maps = await _db.query(tableLivreur);
    if (maps.length > 0) {
    } else {
      await _db.insert(tableLivreur, livreur.toMap()).catchError((e) {
        print(e);
      });
    }
  }

  Future<Livreur> getLivreur(int id) async {
    List<Map> maps = await _db.query(tableLivreur,
        columns: [
          columnId,
          columnLogin,
          columnPassword,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Livreur.fromMap(maps.first);
    } else {
      print('Nothing');
    }
    return null;
  }

  Future insertOrder(Order order) async {
    List<Map> maps = await _db.query(tableLivraison);
    if (maps.length > 0) {
    } else {
      await _db.insert(tableLivraison, order.toMap()).catchError((e) {
        print(e);
      });
    }
  }

  Future<int> updateOrder(Order order) async {
    return await _db.update(tableLivraison, order.toMap(),
        where: '$columnId = ?', whereArgs: [order.id]);
  }

  Future<List <Order>> getAllOrder() async {
    List<Order> orderList = new List();
    List<Map> maps = await _db.query(tableLivraison);
    if (maps.length > 0) {
      maps.forEach((element) {
        orderList.add(Order.fromMap(element));
      });
      return orderList;
    }
    return null;
  }

  Future<Order> getOrder(int id) async {
    List<Map> maps = await _db.query(tableLivraison,
        columns: [
          columnId,
          columnNomPrenoms,
          columnNomProduit,
          columnEtatLivraison,
          columnTel,
          columnCoutTotal,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Order.fromMap(maps.first);
    } else {
      print('Nothing');
    }
    return null;
  }

  Future insertReceptionnaire(Receptionnaire receptionnaire) async {
    List<Map> maps = await _db.query(tableReceptionnaire);
    if (maps.length > 0) {
    } else {
      await _db.insert(tableReceptionnaire,
          receptionnaire.toMap()).catchError((e) {
        print(e);
      });
    }
  }

  Future<Receptionnaire> getReceptionnaire(int id) async {
    List<Map> maps = await _db.query(tableReceptionnaire,
        columns: [
          columnId,
          columnNomPrenoms,
          columnTel
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Receptionnaire.fromMap(maps.first);
    } else {
      print('Noting');
    }
    return null;
  }

  Future close() async => _db.close();
}
