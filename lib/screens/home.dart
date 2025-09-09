import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/utils/firebase.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)), backgroundColor: Theme.of( context).colorScheme.primary,actions: [
        IconButton(onPressed: (){
          firebaseAuth.signOut();
        }, icon: Icon(Icons.exit_to_app,color: Theme.of(context).colorScheme.onPrimary,size: 20,))
      ],),
      body: Center(child: Text('Welcome back ${user.email}')));
  }
}
