import 'package:flutter/material.dart';

import '../model/message.dart';

class MessageItem extends StatelessWidget {
  final bool isFromUser;
  final Message message;
  const MessageItem({
    super.key,
    required this.isFromUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFromUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Card(
            child: ListTile(
              leading: isFromUser
                  ? null
                  : CircleAvatar(
                      radius: 20,
                      backgroundImage: message.avatarUrl != null
                          ? NetworkImage(message.avatarUrl!)
                          : null,
                      backgroundColor: Colors.blueGrey,
                    ),
              title: Text(message.username),
              subtitle: Text(message.text, maxLines: 100),
            ),
          ),
        ),
      ],
    );
  }
}
