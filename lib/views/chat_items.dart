import 'package:flutter/material.dart';
import 'package:geeks_overflow/utils/chat_bloc.dart';
import 'package:provider/provider.dart';


class ChatListWidget extends StatefulWidget {
  @override
  _ChatListWidgetState createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  List<String> messages = [];
  List<String> users = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatBloc>(
      builder: (context, bloc, _) => StreamProvider.value(
        initialData: null,
        value: bloc.chatItemsStream,
        child: Consumer<String>(
          builder: (context, msg, _) {
            if (msg != null && msg.isNotEmpty) {
              messages.add(msg);
              msg="";
            }
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (ctx, id) => _itemBuilder('', messages[id]),
            );
          },
        ),
      ),
    );
  }

  Widget _itemBuilder(String name, String msg) {
    return ListTile(
      title: Text(msg),
    );
  }
}
