import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  final TextEditingController _headlineTextEditingController = TextEditingController();
  final TextEditingController _noteTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Note'),
          actions: [
            IconButton(onPressed: () async{
                // await Supabase.instance.client.from('table1')
                //     .update({'body':_noteTextEditingController.text,
                //   'headline':_headlineTextEditingController.text})
                //     .eq('body', data[index]['body']);
                // Navigator.pop(context);


            }, icon: Icon(Icons.save, color: Colors.black,))
          ],
        ),

        body: Column(
          children: [
            TextField(
              controller: _headlineTextEditingController,
              maxLines: null,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Write a Headline...',
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              style: TextStyle(fontSize: 16),

            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
            TextField(
              controller: _noteTextEditingController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Start typing your note...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              style: TextStyle(fontSize: 16),
            ),
          ],
        )
    ));
  }
}
