import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/model/user.dart';
import 'package:just_chat/utils/firebase.dart';

// import '../model/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final auth.User user;

  Future<User?> fetchUserData() async {
   try {
     final firestore = FirebaseFirestore.instanceFor(app: Firebase.app(),databaseId: 'just-chat-db');
    final userData = (await firestore.collection('users').doc(user.uid).get())
        .data()!;
    return User(
      username: userData['username'],
      id: user.uid,
      email: userData['email'] ?? user.email,
      avatarUrl: userData['imageUrl'],
    );
   } on FirebaseException catch (e){
    //  ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text('Error: ${error?.toString()}')));
    debugPrint('Error: ${e.toString()}');
   }
   return null;
  }

  @override
  Widget build(BuildContext context) {
    // final displayname = user.username?? user.email;
    return FutureBuilder<User?>(
      initialData: User(id: user.uid, email: user.email ?? ''),
      future: fetchUserData(),
      builder: (context, asyncSnapshot) {
        final isLoading =
            asyncSnapshot.connectionState == ConnectionState.waiting;
        final isError = asyncSnapshot.hasError;
        final hasNoData = asyncSnapshot.data == null;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Home',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(
                onPressed: () {
                  firebaseAuth.signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 20,
                ),
              ),
            ],
          ),
          body: isLoading
              ? _buildLoading()
              : (isError || hasNoData)
              ? _buildError()
              : _buildData(asyncSnapshot.data!),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    return Center(child: Text('Something went wrong :()'));
  }

  Widget _buildData(User user) {
    final displayName = user.username ?? user.email;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('Welcome back $displayName'),
          if (user.avatarUrl != null)
            CircleAvatar(radius: 100, child: Image.network(user.avatarUrl!)),
          NewMessageInput(onSendMessage: () {}),
        ],
      ),
    );
  }
}

class NewMessageInput extends StatefulWidget {
  const NewMessageInput({super.key, this.onSendMessage});

  final VoidCallback? onSendMessage;

  @override
  State<NewMessageInput> createState() => _NewMessageInputState();
}

class _NewMessageInputState extends State<NewMessageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      height: 100,
      width: double.infinity,
    );
  }
}
