import 'package:flutter/material.dart';

class NewMessageInput extends StatefulWidget {
  const NewMessageInput({super.key, this.onSendMessage});

  final void Function(String message)? onSendMessage;

  @override
  State<NewMessageInput> createState() => _NewMessageInputState();
}

class _NewMessageInputState extends State<NewMessageInput> {
  final messageInputCtrl = TextEditingController();

  @override
  void dispose() {
    messageInputCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageInputCtrl,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: 'Send a message...'),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    final value = messageInputCtrl.text.trim();
    if (value.isEmpty) {
      return;
    }

    if (widget.onSendMessage != null) {
      widget.onSendMessage!(value);
    }
    FocusScope.of(context).unfocus();
    messageInputCtrl.clear();
  }
}
