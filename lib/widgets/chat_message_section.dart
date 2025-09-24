import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/model/message.dart';
import 'package:just_chat/model/user.dart';
import 'package:just_chat/utils/firebase.dart';
import 'package:just_chat/widgets/message_list.dart';
import 'package:just_chat/widgets/new_message_input.dart';

class ChatMessageSection extends StatelessWidget {
  ChatMessageSection({super.key, required this.user});

  final User user;

  final firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'just-chat-db',
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Center(
              child: StreamBuilder(
                stream: firestore
                    .collection('chat')
                    .orderBy('createdAt', descending: false)
                    .snapshots(includeMetadataChanges: true),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    //TODO:Skeleton for waiting state;
                    return Center(child: CircularProgressIndicator());
                  }

                  if (asyncSnapshot.hasError) {
                    return Center(
                      child: Text('Error currured! ${asyncSnapshot.error}'),
                    );
                  }

                  final messages = asyncSnapshot.data!.docs.map((e) {
                    final mess = e.data();
                    return Message(
                      username: mess['username'] ?? '',
                      userId: mess['userId'] ?? '',
                      text: mess['text'] ?? '',
                      avatarUrl: mess['userImage'],
                    );
                  }).toList();
                  return MesssageList(
                    messages: messages,
                    currentUserId: firebaseAuth.currentUser!.uid,
                  );
                },
              ),
            ),
          ),
          NewMessageInput(
            onSendMessage: (message) => handleSendMessage(message, user),
          ),
        ],
      ),
    );
  }

  void handleSendMessage(String message, User sender) {
    firestore.collection('chat').add({
      'text': message,
      'createdAt': Timestamp.now(),
      'userId': sender.id,
      'username': sender.username?? sender.email,
      'userImage': sender.avatarUrl,
    });
  }
}
