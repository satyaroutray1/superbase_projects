import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  final TextEditingController _headlineTextEditingController = TextEditingController();
  final TextEditingController _noteTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Add a Note'),
        actions: [
          IconButton(onPressed: () async{

              await Supabase.instance.client.from('table1')
                  .insert(
                  {'body': _noteTextEditingController.text,
                    'headline': _headlineTextEditingController.text}).then((
                  value) {
                Navigator.pop(context);
              });

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
              labelText: 'Headline',
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
              labelText: 'Notes',
            ),
            style: TextStyle(fontSize: 16),
          ),
        ],
      )
    ));
  }
}
