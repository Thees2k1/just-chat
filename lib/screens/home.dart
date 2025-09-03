import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Welcome back ${user.email}')));
  }
}
