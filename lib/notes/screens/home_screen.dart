import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superbase_projects/notes/screens/login_screen.dart';
import 'package:superbase_projects/notes/screens/note_screen.dart';
import 'package:superbase_projects/notes/screens/profile.dart';

import 'edit_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // full opacity
      random.nextInt(256), // red: 0–255
      random.nextInt(256), // green
      random.nextInt(256), // blue
    );
  }
  @override
  Widget build(BuildContext context) {

    final a = Supabase.instance.client.from('table1').stream(primaryKey: ['id']);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
    
          title: Text('Notes App'),
        actions: [
          IconButton(onPressed: () async{
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Profile();
            }));
            }, icon: Icon(Icons.person),)
        ],),
        body: SafeArea(
          child: StreamBuilder(stream: a,
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
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                            color: getRandomColor().withOpacity(.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index]['headline']??'', style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              SizedBox(
                                height: 10,
                              ),
                              Text(data[index]['body']),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(data[index]['created_at'])),
                                  style: TextStyle(
                                    color: Colors.grey
                                  ),)
                                ],
                              ),
              
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
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return NoteScreen();
          }));
      }, child: Icon(Icons.add, color: Colors.white,),),
    );
  }
}