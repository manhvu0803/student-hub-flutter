import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

class ChatPage extends StatefulWidget {
  final String ownerUsername;

  final String recipientUsername;

  const ChatPage({
    super.key,
    required this.ownerUsername,
    required this.recipientUsername
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late chat.User _owner;

  late chat.User _recipient;

  final List<chat.Message> _messages = [];

  @override
  void initState() {
    super.initState();

    _owner = chat.User(
      id: widget.ownerUsername,
      role: chat.Role.user
    );

    _recipient = chat.User(
      id: widget.recipientUsername,
      role: chat.Role.user
    );

    _messages.addAll(_getSentMessages());
  }

  List<chat.Message> _getSentMessages() {
    return [
      chat.TextMessage(
        author: _recipient,
        createdAt: DateTime.now().subtract(Durations.long4).millisecondsSinceEpoch,
        id: "1",
        text: "Hello, I'm Luis"
      ),
      chat.TextMessage(
        author: _owner,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: "0",
        text: "Hello"
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      child: Chat(
        user: _owner,
        onSendPressed: onSendPressed,
        messages: _messages.reversed.toList(),
      )
    );
  }

  void onSendPressed(chat.PartialText text) {
    setState(() => _messages.add(
      chat.TextMessage(
        author: _owner,
        id: _messages.length.toString(),
        text: text.text,
        createdAt: DateTime.now().millisecondsSinceEpoch
      )
    ));
  }
}