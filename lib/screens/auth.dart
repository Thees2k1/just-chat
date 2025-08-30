import 'package:flutter/material.dart';
import 'package:just_chat/constants/common.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(Assets.chatImage),
            ),
            SizedBox(height: 12,),
            Card(
              child: Form(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextFormField(keyboardType: TextInputType.emailAddress,initialValue: "example@gmail.com",),
                  const SizedBox(height: 8,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                ],),
              )
              ),
            )
          ],
        ),
      ),
    );
  }
}