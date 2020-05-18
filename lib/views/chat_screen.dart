import 'package:flutter/material.dart';
import 'package:geeks_overflow/utils/chat_bloc.dart';
import 'package:geeks_overflow/utils/constants.dart';
import 'package:geeks_overflow/views/chat_controller.dart';
import 'package:geeks_overflow/views/chat_items.dart';
import 'package:geeks_overflow/views/var.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Socket socket;
  @override
  void initState() {
    super.initState();
    socket = io(Var.link, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: socket,
      child: ProxyProvider<Socket, ChatBloc>(
        update: (context, socket, previousBloc) {
          return ChatBloc(Provider.of<Socket>(context));
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ChatListWidget(),
            ),
            ChatControllerWidget(),
          ],
        ),
      ),
    );
  }
}
