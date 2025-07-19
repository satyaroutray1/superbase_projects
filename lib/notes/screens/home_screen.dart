import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBar(title: Text('Notes App'),),
        body: Center(
          child: Text('data'),
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        
      }, child: Icon(Icons.add),),
    ));
  }
}
