import 'package:flutter/material.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _State<HomePage>();
}

class _State<HomePage> extends State{

  @override
  Widget build(BuildContext context){
    return Scaffold();
  }
}