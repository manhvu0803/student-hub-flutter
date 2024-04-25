import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/dialog_view/schedule_interview_view.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';
import 'package:student_hub_flutter/settings.dart' as settings;
import 'package:student_hub_flutter/client.dart' as client;
import 'package:student_hub_flutter/client/chat_client.dart' as client;

class ChatPage extends StatefulWidget {
  final User recipient;
  final Project project;

  const ChatPage({
    super.key,
    required this.project,
    required this.recipient
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late chat.User _owner;
  late chat.User _recipient;
  List<chat.Message> _chatMessages = [];
  late final Timer timer;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();

    _owner = chat.User(
      id: client.user?.id.toString() ?? "-1",
      role: chat.Role.user
    );

    _recipient = chat.User(
      id: widget.recipient.id.toString(),
      role: chat.Role.user
    );

    _fetchMessages();

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) => _fetchMessages()
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      title: "${widget.recipient.fullName} - ${widget.project.title}",
      actions: [MenuAnchor(
        menuChildren: [
          MenuItemButton(
            child: const Text("Schedule meeting"),
            onPressed: () => _showInterviewDialog(context),
          )
        ],
        builder: (context, controller, child) => IconButton(
          onPressed: () => controller.isOpen ? controller.close() : controller.open(),
          icon: const Icon(Icons.more_vert)
        ),
      )],
      child: chat_ui.Chat(
        user: _owner,
        onSendPressed: (text) => onSendPressed(context, text),
        messages: _chatMessages.reversed.toList(),
        theme: settings.isDarkMode ? const chat_ui.DarkChatTheme() : const chat_ui.DefaultChatTheme(),
      )
    );
  }

  Future<void> _fetchMessages() async {
    if (_isFetching) {
      return;
    }

    _isFetching = true;

    try {
      var messages = await client.getChatMessages(
        projectId: widget.project.id,
        recipientId: widget.recipient.id
      );

      setState(() => _chatMessages = messages.mapToList(_getChatMessage));
    }
    catch (e) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        context.showTextSnackBar(e.toString());
      }
    }

    _isFetching = false;
  }

  chat.Message _getChatMessage(Message message) {
    return chat.TextMessage(
      author: (message.sender.id == widget.recipient.id) ? _recipient : _owner,
      createdAt: message.createdAt.millisecondsSinceEpoch,
      id: message.id.toString(),
      text: _getMessageContent(message)
    );
  }

  String _getMessageContent(Message message) {
    if (message.meeting != null) {
      var meeting = message.meeting!;
      var buffer = StringBuffer("Meeting: ");
      buffer.write(meeting.title);
      buffer.write("\nFrom: ");
      buffer.write(meeting.startTime.toDateTimeString());
      buffer.write("\nTo: ");
      buffer.write(meeting.endTime.toDateTimeString());

      if (message.content.isNotEmpty) {
        buffer.write(meeting.content);
      }

      return buffer.toString();
    }

    return message.content;
  }

  Future<void> onSendPressed(BuildContext context, chat.PartialText text) async {
    setState(() => _chatMessages.add(
      chat.TextMessage(
        author: _owner,
        id: _chatMessages.length.toString(),
        text: text.text,
        createdAt: DateTime.now().millisecondsSinceEpoch
      )
    ));

    try {
      await client.sendMessage(
        projectId: widget.project.id,
        recipientId: widget.recipient.id,
        content: text.text
      );
    }
    catch (e, stackTrace) {
      print(stackTrace);
      if (context.mounted) {
        context.showTextSnackBar(e.toString());
      }
    }
  }

  void _showInterviewDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ScheduleInterviewView(
          projectId: widget.project.id,
          receiverId: widget.recipient.id,
        ),
      )
    );
  }
}