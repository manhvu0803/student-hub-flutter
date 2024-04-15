import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/pages/chat_page.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/client.dart' as client;
import 'package:student_hub_flutter/client/chat_client.dart' as client;

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SearchBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 8, top: 2),
              child: Icon(Icons.search),
            ),
            hintText: "Search...",
            hintStyle: MaterialStatePropertyAll(TextStyle(fontStyle: FontStyle.italic)),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RefreshableFutureBuilder(
              fetcher: () => client.getAllChat(),
              builder: (context, data) => ListView(
                children : data.mapToList((message) => _ChatTitleCard(
                  username: message.receiver.fullName,
                  title: message.project.title,
                  lastMessage: message.content,
                  lastMessageTime: message.createdAt,
                  onTap: () => pushChatPage(context, message)
                ))
              ),
            ),
          ),
        )
      ],
    );
  }

  pushChatPage(BuildContext context, Message message) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
      masterMessage: message,
      recipient: message.getOther(client.user!),
    )));
  }
}

class _ChatTitleCard extends StatelessWidget {
  final ImageProvider? avatar;
  final String username;
  final String title;
  final String lastMessage;
  final DateTime lastMessageTime;
  final void Function()? onTap;

  const _ChatTitleCard({
    // ignore: unused_element
    this.avatar,
    required this.username,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Card(
        child: InkWell(
          onTap: (onTap == null) ? () {} : onTap,
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 6),
            child: ListTile(
              leading: SizedBox(
                width: 48,
                height: 48,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: avatar,
                  child: (avatar == null) ? const Icon(Icons.person) : null,
                )
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    username,
                    style: context.textTheme.titleLarge
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall!.copyWith(fontSize: 14)
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "You: $lastMessage",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Text(lastMessageTime.toDateString()),
            ),
          ),
        ),
      ),
    );
  }
}