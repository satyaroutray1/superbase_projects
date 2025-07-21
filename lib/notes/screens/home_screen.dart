import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superbase_projects/notes/screens/note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    final a = Supabase.instance.client.from('table1').stream(primaryKey: ['id']);
    return SafeArea(child: Scaffold(
        appBar: AppBar(title: Text('Notes App'),),
        body: StreamBuilder(stream: a,
            builder: (context, snapshot) {
          if(snapshot.hasData){
            final data = snapshot.data as List;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async{
                      print(data[index]['body']);
                      await Supabase.instance.client.from('table1').delete()
                      //update({'body':'updated data1'})
                      .eq('body', data[index]['body']);
                    },
                    child: Slidable(
                      key: Key(data[index]['id'].toString()),
                      startActionPane: ActionPane(
                        motion:  ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            //onPressed: {},
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (BuildContext context) {  },
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) {  },
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),

                      child: Card(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index]['headline']??'', style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              Text(data[index]['body']),
                          
                            ],
                          ),
                        ),
                      ),
                    )
                  );
                }
            );
          }
          return Container();
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         // smartAlertDialog(context, _textEditingController);
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return NoteScreen(title: 'Write a Note',);
          }));
      }, child: Icon(Icons.add),),
    ));
  }
}