import 'dart:async';
import 'dart:io';

import 'package:loan_app/model/loan.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:loan_app/model/customer.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "loanapp.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE customer ("
              "id INTEGER PRIMARY KEY,"
              "customerid INTEGER,"
              "customername TEXT,"
              "dob TEXT"
              ")");

          await db.execute("CREATE TABLE loan ("
              "id INTEGER PRIMARY KEY,"
              "accountid INTEGER,"
              "customerid INTEGER,"
              "amount FLOAT,"
              "date TEXT"
              ")");

        });
  }

  newCustomer(Customer newCustomer) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM customer");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into customer (id,customerid,customername,dob)"
            " VALUES (?,?,?,?)",
        [ id,newCustomer.customerId, newCustomer.customerName, newCustomer.dob]);
    return raw;
  }

  newLoan(Loan newLoan,int cid) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM loan");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into loan (id,accountid,customerid,amount,date)"
            " VALUES (?,?,?,?,?)",
        [ id,newLoan.accountid, cid, newLoan.amount,newLoan.date]);
    return raw;
  }



  Future<List<Customer>> getAllCustomers() async {
    final db = await database;
    var res = await db.query("customer");
    List<Customer> list =
    res.isNotEmpty ? res.map((c) => Customer.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Loan>> getallLoan() async{
    final db = await database;
    var result = await db.query("loan");
    List<Loan> list = result.isNotEmpty ? result.map((c)=>Loan.fromMap(c)).toList() : [];
    return list;
  }

}