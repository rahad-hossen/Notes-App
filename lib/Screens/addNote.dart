import 'package:flutter/material.dart';
import 'package:notes/Local_DB/database.dart';
import 'package:notes/Models/models.dart';

class AddNote extends StatefulWidget {

  const AddNote( {super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();

  dbHelper db = dbHelper();

  final time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Title Input
            TextFormField(
              controller: _title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),

            ),
            const SizedBox(height: 10),

            // Date or Category Indicator (Optional)
            Row(
              children: [

                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  time.toString(),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Note Body Input
            Expanded(
              child: TextFormField(
                controller: _body,
                maxLines: null,
                style: const TextStyle(fontSize: 18, height: 1.5),
                decoration: const InputDecoration(
                  hintText: "Start typing your thoughts...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),

      // Save Button
      floatingActionButton: FloatingActionButton.extended(

        onPressed: () async {
          String title = _title.text;
          String body = _body.text;

          if(title == null || title.isEmpty || body == null || body.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your note")));
          }else{
            NotesModel note = NotesModel(Title: title , Body: body);
            await db.insertData(note);
            Navigator.pop(context);
          }

        },
        backgroundColor: Colors.black,
        icon: const Icon(Icons.save_outlined, color: Colors.white),
        label: Text("Save Note", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}