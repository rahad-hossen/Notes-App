import 'package:flutter/cupertino.dart';
import 'package:notes/Local_DB/database.dart';
import 'package:notes/Models/models.dart';

class noteProvider with ChangeNotifier{

  List<NotesModel> note = [];
  dbHelper db = dbHelper();

  noteProvider(){
    getNotes();
  }

  getNotes() async{
    note = await db.GetNotes();
    notifyListeners();
  }

  insertNote(NotesModel note) async{
    await db.insertData(note);
    getNotes();
  }

  updateNote(NotesModel note) async{
    await db.UpdateData(note);
    getNotes();
  }

  deleteNote(NotesModel note) async{
    await db.DeleteData(note);
    getNotes();
  }


}