import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superbase_projects/notes/screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  final url = dotenv.env['URL'];
  final anonKey = dotenv.env['ANONKEY'];

  if (url == null || url.isEmpty || anonKey == null || anonKey.isEmpty) {
    throw Exception('Supabase URL or Anon Key is missing');
  }

  await Supabase.initialize(url: url, anonKey: anonKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}