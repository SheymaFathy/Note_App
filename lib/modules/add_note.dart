// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:note_app/modules/home.dart';
import 'package:note_app/sqldb/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Add Notes',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Form(
                key: formState,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: TextFormField(
                        controller: note,
                        decoration: const InputDecoration(hintText: 'Add Note'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: TextFormField(
                        controller: title,
                        decoration:
                            const InputDecoration(hintText: 'Add title'),
                      ),
                    ),
                
                    ElevatedButton(
                        onPressed: () async {
                          // int response = await sqlDb.insertData(
                          //     "INSERT INTO notes(note, title) VALUES ('${note.text}', '${title.text}')");
                          int response = await sqlDb.insert("notes", {
                            "note": note.text,
                            "title": title.text,
                          });
                          if (response > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false);
                          }
                        },
                        child: const Text("Confirm"))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
