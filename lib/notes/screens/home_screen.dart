import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  Future<Future> smartAlertDialog(BuildContext context, TextEditingController textFieldController) async {
    return showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: Text('To Do Task'),
              content: TextField(
                controller: textFieldController,
                decoration: InputDecoration(
                    hintText: "Task"),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () async{
                    Navigator.pop(context);
                    await Supabase.instance.client.from('table1').insert({'body':_textEditingController.text});

                  },
                ),
              ],
            ));
  }

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
                  return ListTile(
                    title: Text(data[index]['body']),
                  );
                }
            );
          }
          return Container();
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          smartAlertDialog(context, _textEditingController);
      }, child: Icon(Icons.add),),
    ));
  }
}