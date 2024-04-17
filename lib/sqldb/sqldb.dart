import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb{

  static Database? _db;
  Future<Database?> get db async{
    if (_db == null){
      _db = await initialDb();
      return _db;
    }else{
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath , 'mynotes.db');
    Database mydb = await openDatabase(path , onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }
  _onUpgrade(Database db, int oldversion, int newversion){
    print("_onUpgrade ==============================");
  }
  _onCreate(Database db , int version)async{
    await db.execute(
        "CREATE TABLE notes('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'note' TEXT )");
    print(" _onCreate ==============================");
  }




// getData
readData(String sql)async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
}
// insertData
  insertData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  // updateData
  updateData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
  // deleteData
  deleteData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}