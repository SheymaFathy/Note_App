// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:note_app/modules/home.dart';
import 'package:note_app/sqldb/sqldb.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, this.note, this.title, this.id});
  final note;
  final title;
  final id;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Edit Notes',
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
                          int response = await sqlDb.update("notes", {
                            "note": note.text,
                            "title": title.text,
                          }, 'id = ${widget.id}');
                          // int response = await sqlDb.updateData(
                          //  "UPDATE notes set note ='${note.text}',title = '${title.text}'WHERE id = ${widget.id}");
                          if (response > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                    (route) => false);
                          }
                        },
                        child: const Text("Edit Note"))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
