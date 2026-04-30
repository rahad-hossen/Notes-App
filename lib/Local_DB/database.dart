import 'package:notes/Models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper{

  Database? db_;
  Future<Database> get isDbAvaiable async {
    if(db_ != null) return db_!;
    db_ =await data();
    return db_!;
  }

  Future<Database> data() async{
    final database = openDatabase(
      join( await getDatabasesPath(), "notes.db",),
        onCreate: (dB,version){
        return dB.execute("CREATE TABLE Notes(id INTEGER PRIMARY KEY,title TEXT, body TEXT)");

    },
    version: 1,

    );
    return database;
  }


  Future<void> insertData(NotesModel note) async {
    final db = await isDbAvaiable;
    await db.insert("Notes",note.toMap() );
  }

  Future<void> UpdateData(NotesModel note) async {
    final db = await isDbAvaiable;
    await db.update("Notes", note.toMap(),where: "id = ?",whereArgs: [note.id]);
  }


  Future<void> DeleteData(NotesModel note) async {
    final db = await isDbAvaiable;
    await db.delete("Notes", where: "id = ?", whereArgs: [note.id]);
  }

   Future<List<NotesModel>> GetNotes() async {
    List<NotesModel> notes = [];
    final db = await isDbAvaiable;
    final data_ = await db.query("Notes");

    for (var note in data_){
      NotesModel Mynote = NotesModel.fromMap(note);
      notes.add(Mynote);
    }
    return notes;

  }





}