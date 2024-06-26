import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/extensions/date_time_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/models/message.dart';
import 'package:student_hub_flutter/screens/pages/chat_page.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/client.dart' as client;
import 'package:student_hub_flutter/client/chat_client.dart' as client;

class ChatListView extends StatelessWidget {
  final Future<List<Message>> Function()? chatGetter;
  final bool hasSearchBar;

  const ChatListView({super.key, this.chatGetter, this.hasSearchBar = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasSearchBar) const Padding(
          padding: EdgeInsets.only(top: 12, left: 8.0, right: 8.0),
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
            child: RefreshableFutureBuilder.forCollection(
              emptyString: "No messages found",
              fetcher: chatGetter ?? () => client.getAllChat(),
              builder: (context, data) => ListView(
                children : data.mapToList((message) {
                  var other = message.getOther(client.user!);
                  return _ChatTitleCard(
                    username: other.fullName,
                    title: message.project.title,
                    lastMessage: message.content,
                    lastMessageTime: message.createdAt,
                    isLastMessageUser: message.sender.id == client.user!.id,
                    onTap: () => _pushChatPage(context, message)
                  );
                })
              ),
            ),
          ),
        )
      ],
    );
  }

  _pushChatPage(BuildContext context, Message message) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
      project: message.project,
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
  final bool isLastMessageUser;

  const _ChatTitleCard({
    // ignore: unused_element
    this.avatar,
    required this.username,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    this.onTap,
    this.isLastMessageUser = true
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
                  "${isLastMessageUser ? "You" : "Other"}: $lastMessage",
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