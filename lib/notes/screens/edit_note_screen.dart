import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.id, required this.headline, required this.note});
  final String id, headline, note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  late final TextEditingController _headlineTextEditingController;
  late final TextEditingController _noteTextEditingController;

  @override
  void initState() {
    super.initState();
    _headlineTextEditingController = TextEditingController(text: widget.headline);
    _noteTextEditingController = TextEditingController(text: widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Note'),
          actions: [
            IconButton(onPressed: () async{
                await Supabase.instance.client.from('table1')
                    .update({'body':_noteTextEditingController.text,
                  'headline':_headlineTextEditingController.text})
                    .eq('id', widget.id);
                Navigator.pop(context);

            }, icon: Icon(Icons.save, color: Colors.black,))
          ],
          backgroundColor: Colors.black45,
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _headlineTextEditingController ,
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
            ),
          ),
        )
    );
  }
}
