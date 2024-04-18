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
    Database mydb = await openDatabase(path , onCreate: _onCreate, version: 5, onUpgrade: _onUpgrade);
    return mydb;
  }
  _onUpgrade(Database db, int oldversion, int newversion)async{
    // ignore: avoid_print
    print("_onUpgrade ==============================");
    // to add column to database without delete it to save our data first step change the version number then add column see bellew line.
    // await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }
  _onCreate(Database db , int version)async{
    Batch batch= db.batch();
    // عند اضافة جدول اخر فقط ننسخ الجزء الخاص بالجدول التالي ونعدل الاسماء
     batch.execute(
        "CREATE TABLE notes('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'note' TEXT , 'title' TEXT)");
         await batch.commit();
    // ignore: avoid_print
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

  // delete database
  mydeleteDatabase()async{
    String databasepath =  await getDatabasesPath();
    String path = join(databasepath , 'mynotes.db');
    await deleteDatabase(path);
  }





//اكواد مختصرة 
// getData
  read(String table)async{
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }
// insertData
  insert(String table, Map<String, Object?> values)async{
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }
  // updateData
  update(String table, Map<String, Object?> values, String? mywhere)async{
    Database? mydb = await db;
    int response = await mydb!.update(table, values,where:  mywhere);
    return response;
  }
  // deleteData
  delete(String table, String? mywhere)async{
    Database? mydb = await db;
    int response = await mydb!.delete(table , where: mywhere);
    return response;
  }

  // delete database

}