import 'package:sqflite/sqflite.dart';

late Database db;

initDataBase() async {
 db = await openDatabase(
    'report.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Reportdb (id INTEGER PRIMARY KEY, tittle TEXT, subtittle TEXT, date TEXT, url TEXT)');
    },
  );
}

addLocalDataBase(String tittle, String subtittle, String date,String url) async {
  await db.rawInsert(
      'INSERT INTO Reportdb(tittle, subtittle, date, url) VALUES(?,?,?,?)',
      [tittle, subtittle, date,url]);
}




