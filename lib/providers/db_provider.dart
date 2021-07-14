import 'dart:io';

import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {

  static  Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  
  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null, we instantiate it
    _database = await _initDB();

    return _database;
  }
    
    
    
  

  Future<Database> _initDB() async {
    
    //Path de donde alamcenaremos la base de datos
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final path = join( appDocPath, 'ScansDB.db' );
    print(path);

    //Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) { },
      onCreate: (Database db, int version) async{

        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY, 
            tipo TEXT,
            valor TEXT
          )
        '''); //String multilinea

      }
    );

  }

  //1 Forma de insertar Datos
  Future<int> nuevoScanRaw( ScanModel nuevoScan ) async {

    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await database; //Espera que la base de datos esté lista

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES ($id, '$tipo', '$valor')
    ''');

    return res;

  }

  //Segunda fomra de insertar Datos 
  Future<int> nuevoScan( ScanModel nuevoScan ) async {

    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    
    //res = ID del ultimo registro insertado
    return res;

  }

  Future<ScanModel> getScanById(int id) async {

    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]); 

    return res.isNotEmpty
          ? ScanModel.fromJson(res.first)
          :null;

  }

  Future<List<ScanModel>> getTodosLosScans() async {

    final db = await database;
    final res = await db.query('Scans'); 

    return res.isNotEmpty
          ? res.map((e) => ScanModel.fromJson(e) ).toList()
          :[];

  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {

    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]); 

    return res.isNotEmpty
          ? res.map((e) => ScanModel.fromJson(e) ).toList()
          :[];

  }

  Future<int> updateScan(ScanModel nuevoScan) async {

    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;

  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');

    return res;
  }

}