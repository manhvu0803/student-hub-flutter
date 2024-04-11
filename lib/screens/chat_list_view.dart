import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/screens/chat_page.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        const SearchBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 8, top: 2),
            child: Icon(Icons.search),
          ),
          hintText: "Search...",
          hintStyle: MaterialStatePropertyAll(TextStyle(fontStyle: FontStyle.italic)),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView(
            children: [
              _ChatTitleCard(
                avatar: const NetworkImage("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                username: "Luis Pham",
                title: "Senior frontend developer (Fintech)",
                lastMessage: "Clear expectation about your project or deliverables",
                lastMessageTime: DateTime.now(),
                onTap: () => pushChatPage(context, "Luis"),
              ),
              _ChatTitleCard(
                avatar: const NetworkImage("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                username: "Luis Tran",
                title: "Frontend developer (Fintech)",
                lastMessage: "HELLO",
                lastMessageTime: DateTime.now(),
                onTap: () {},
              )
            ],
          ),
        )
      ],
    );
  }

  pushChatPage(BuildContext context, String recipient) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
      ownerUsername: "Me",
      recipientUsername: recipient,
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
      padding: const EdgeInsets.only(bottom: 2),
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
                  backgroundImage: avatar
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
              subtitle: Text(
                lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(lastMessageTime.toDateString()),
            ),
          ),
        ),
      ),
    );
  }
}