import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatBloc {
  final Socket socket;

 StreamController<String> _textFieldCtrl = StreamController<String>();
StreamController<bool> _submitBtnCtrl = StreamController<bool>();
StreamController<String> _chatItemsCtrl = StreamController<String>();

  ChatBloc(this.socket) {

    _textFieldCtrl.stream.listen((value) {
      _submitBtnCtrl.sink.add(value != null && value.isNotEmpty);
    socket.connect();

    socket.on('connect_error', (value) {
      // handle
    });    });


   socket.on('new-message', (jsondata) {
     // json.decode(jsondata);
      _chatItemsCtrl.sink.add(jsondata["user"]+":    "+jsondata["msg"]);
   //   print(jsondata);
    });
  }

  sendMessage(String message) {

    socket.emit('new-message',({'msg':message,'name':'firas'}));
   // print(message);
  }

 Stream<bool> get submitButtonStream => _submitBtnCtrl.stream;
Stream<String> get chatItemsStream => _chatItemsCtrl.stream;
  void onTextValueChange(String value) => _textFieldCtrl.sink.add(value);

  Stream dispose() {
   _textFieldCtrl.close();
    _submitBtnCtrl.close();
    _chatItemsCtrl.close();
  }
  }
