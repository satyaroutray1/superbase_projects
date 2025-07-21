import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superbase_projects/notes/screens/note_screen.dart';

import 'edit_note_screen.dart';

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
                  return  Slidable(
                    key: Key(data[index]['id'].toString()),
                    startActionPane: ActionPane(
                      motion:  ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          onPressed: (BuildContext context) async{
                            await Supabase.instance.client.from('table1').delete()
                                .eq('body', data[index]['body']);
                          },
                        ),

                        SlidableAction(
                          onPressed: (BuildContext context) {

                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return EditNoteScreen(id: data[index]['id'].toString(),
                                headline: data[index]['headline'] ?? '',
                                note: data[index]['body'],);
                            }));
                          },
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(data[index]['created_at'])))
                              ],
                            )


                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
          return Container();
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return NoteScreen();
          }));
      }, child: Icon(Icons.add),),
    ));
  }
}