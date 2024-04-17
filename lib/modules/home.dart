import 'package:flutter/material.dart';
import 'package:note_app/sqldb/sqldb.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
   HomePage({super.key});

SqlDb sqlDb = SqlDb();
Future<List<Map>> readData()async{
  List<Map> response = await sqlDb.readData("SELECT * FROM notes");
  return response;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: ListView(
          children: [
            FutureBuilder(
              future: readData(),
             builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot ){
              if (snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return  Card(child: ListTile(
                      title: Text("${snapshot.data![i]['note']}"),
                    ));
                    },

                );
              }
              return const Center(child: CircularProgressIndicator(),);
             }),
               Center(child: ElevatedButton(
            onPressed: ()async{
            List<Map> response = await sqlDb.readData("INSERT INTO notes  ('note') VALUES ('Note 222') ") ;
             print(response);
            },
            child: const Text("طلب شراء",),))
          ],
        ),
      ),
    );
  }
}