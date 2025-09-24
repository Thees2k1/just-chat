import 'package:flutter/material.dart';
import 'package:just_chat/model/message.dart';
import 'package:just_chat/widgets/message_item.dart';

class MesssageList extends StatelessWidget {
  final List<Message> messages;
  final String currentUserId;
  const MesssageList({super.key, required this.messages,required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return Center(child: Text('No Messages'));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return MessageItem(
          isFromUser: messages[index].userId == currentUserId,
          message: messages[index],
        );
      },
      itemCount: messages.length,
    );
  }
}

