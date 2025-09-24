import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/model/user.dart';
import 'package:just_chat/utils/firebase.dart';
import 'package:just_chat/widgets/chat_message_section.dart';
import 'package:just_chat/widgets/skeletons/avatar_skeleton.dart';

// import '../model/user.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.user});

  final auth.User user;
  final firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'just-chat-db',
  );

  Future<User?> fetchUserData() async {
    try {
      final document = await firestore.collection('users').doc(user.uid).get();
      if (document.exists) {
        final userData = document.data()!;
        return User(
          username: userData['username'],
          id: user.uid,
          email: userData['email'] ?? user.email,
          avatarUrl: userData['imageUrl'],
        );
      }
      return User(email: user.email ?? '', id: user.uid);
    } on FirebaseException catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // final displayname = user.username?? user.email;
    return FutureBuilder<User?>(
      future: fetchUserData(),
      builder: (context, asyncSnapshot) {
        final isLoading =
            asyncSnapshot.connectionState == ConnectionState.waiting;
        final isError = asyncSnapshot.hasError;
        final hasNoData = asyncSnapshot.data == null;
        final displayName = asyncSnapshot.data?.username ?? user.email;

        return Scaffold(
          appBar: AppBar(
            title: (isLoading || isError || hasNoData)
                ? Row(children: [const AvartarSkeleton()])
                : Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: asyncSnapshot.data!.avatarUrl != null
                            ? NetworkImage(asyncSnapshot.data!.avatarUrl!)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          children: [
                            TextSpan(text: 'Welcome back, '),
                            TextSpan(
                              text: displayName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: '!'),
                          ],
                        ),
                      ),
                    ],
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
    return Center(child: Text('Something went wrong :('));
  }

  Widget _buildData(User user) {
    return ChatMessageSection(user: user);
  }
}
