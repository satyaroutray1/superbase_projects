import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superbase_projects/notes/screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xctvdwrmszxnarqerctp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhjdHZkd3Jtc3p4bmFycWVyY3RwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI4MTUzNDMsImV4cCI6MjA2ODM5MTM0M30.4QbUzJ8oO5k7xoz_I2Jh3mCrrfPqaUJwgcS41JBF7A8',
  );
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