
import 'dart:convert';
import 'dart:math';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/services/UserService.dart';
import 'package:geeks_overflow/views/profile/merchscreen.dart';
import 'package:geeks_overflow/views/var.dart';
import 'package:http/http.dart';

class FirstPageScreen extends StatefulWidget {
  @override
  _FirstPageScreenState createState() => _FirstPageScreenState();

  const FirstPageScreen();
}

class _FirstPageScreenState extends State<FirstPageScreen>
{
  final SearchBarController<User> _searchBarController = SearchBarController();
  bool isReplay = false;
  UserService userService = new UserService();

  Future<List<User>> _getALlPosts(String text) async {
    return this.userService.findUser(text);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<User>(
          onSearch: _getALlPosts,
          onItemFound: (User user, int index) {
            return ListTile(
              onTap: () {
                print(user.username);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MerchScreen(user: user)),
                );
              },
              leading: CircleAvatar(
                backgroundImage: new NetworkImage(
                    Var.link+"/avatars/"+user.id+".jpg"), // no matter how big it is, it won't overflow
              ),
              title: Text(user.username),
              subtitle: Text(""),
            );
          },
        ),
      ),
    );
  }
}