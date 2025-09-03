import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/constants/common.dart';
import 'package:just_chat/screens/auth.dart';
import 'package:just_chat/screens/home.dart';
import 'package:just_chat/utils/firebase.dart';
import 'package:just_chat/utils/router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Global.appName,
      theme: Global.appTheme,
      home: StreamBuilder(stream: firebaseAuth.authStateChanges(), builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
        if(snapshot.hasData){
          return HomeScreen(user: snapshot.data!);
        }

        return const AuthScreen();
      })
    );
  }
}
