import 'package:flutter/material.dart';
import 'package:notes/Provider/noteProvider.dart';
import 'package:notes/Screens/addNote.dart';
import 'package:notes/Screens/updateNote.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "My Notes",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: Consumer<noteProvider>(
          builder: (context, provider, child){

            return provider.note.isEmpty? Center(child: Text("No note found"),): ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.note.length,
              itemBuilder: (context, index) {
                final notes_ = provider.note[index];

                return InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateNote(notes_.id as int,notes_.Title,notes_.Body)));

                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              notes_.Title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(20),
                                      height: 180,
                                      child: Column(
                                        children: [

                                          ListTile(
                                            leading: const Icon(Icons.edit, color: Colors.blue),
                                            title: const Text('Update Note'),
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateNote(notes_.id as int,notes_.Title,notes_.Body)));

                                            },
                                          ),

                                          ListTile(
                                            leading: const Icon(Icons.delete, color: Colors.grey),
                                            title: const Text('Delete Note'),
                                            onTap: () async {
                                              await provider.deleteNote(notes_);

                                            },

                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.more_horiz, color: Colors.grey[400]),
                            ),
                            // Icon(Icons.more_horiz, color: Colors.grey[400]),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notes_.Body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Work",
                                style: TextStyle(color: Colors.blue[700], fontSize: 10),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "2 hours ago",
                              style: TextStyle(color: Colors.grey[400], fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );

          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNote()));
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}