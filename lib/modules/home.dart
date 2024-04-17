import 'package:flutter/material.dart';
import 'package:note_app/modules/edit_note.dart';
import 'package:note_app/sqldb/sqldb.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
SqlDb sqlDb = SqlDb();
bool isLoading = true;
List notes = [];
Future readData()async{
  List<Map> response = await sqlDb.read("notes");
  notes.addAll(response);
  isLoading = false;
  if (this.mounted){
    setState(() {
    });
  }
}
@override
  void initState() {
  readData();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Notes", style: TextStyle(color: Colors.purple),),
      centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade700,
        onPressed: (){
        Navigator.of(context).pushNamed("addnotes");
       },child:const Icon(Icons.add,color: Colors.white,),),
      body: isLoading? const Text('Loadind.....'): Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            // Center(child: ElevatedButton(
            //   onPressed: ()async{
            //     await sqlDb.mydeleteDatabase();
            //     // List<Map> response = await sqlDb.readData("INSERT INTO notes  ('note') VALUES ('Note 222') ") ;
            //     //  print(response);
            //   },
            //   child: const Text("طلب شراء",),)),
         ListView.builder(
                  itemCount: notes.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return  Card(child: ListTile(
                      title: Text("${notes[i]['title']}"),
                      subtitle: Text("${notes[i]['note']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:  Icon(Icons.delete,color: Colors.purple.shade700,),
                            onPressed: ()async{
                            // int response = await sqlDb.deleteData("DELETE FROM notes WHERE id = ${notes[i]['id']}");
                              int response = await sqlDb.delete("notes", "id = ${notes[i]['id']}");
                            if(response > 0){
                              notes.removeWhere((element) => element['id']== notes[i]['id']);
                              setState(() {
                              });
                            }
                            print(response);
                          }, ),
                          IconButton(
                            icon:  Icon(Icons.edit, color: Colors.purpleAccent.shade100,),
                            onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder:(context)=> EditNote(
                              note: notes[i]['note'],
                              title: notes[i]['title'],
                              id: notes[i]['id'],
                            )));

                          }, ),
                        ],
                      )
                    ));
                    },

                )



          ],
        ),
      ),
    );
  }
}