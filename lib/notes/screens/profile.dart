import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Colors.black45,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('Email ID: '),
                      Text(Supabase.instance.client.auth.currentUser!.email!),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Created On: '),
                      Text(DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(Supabase.instance.client.auth.currentUser!.createdAt))),
            
                    ],
                  ),
                ],
              ),
              ElevatedButton(onPressed: (){
                Supabase.instance.client.auth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return  LoginPage();
                }));
              }, child: Center(child: Text('Logout')))
            ],
          ),
        ),
      ),
    );
  }
}
