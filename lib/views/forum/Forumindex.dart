import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/ForumCategory.dart';
import 'package:geeks_overflow/services/ForumService.dart';

import 'package:http/http.dart' as http;


import 'ListSubreddits.dart';





class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Forum';
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFFFFAD32),
      ),
      home: new HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text(title,
        style: new TextStyle(
          color: const Color(0xFFFFFFFF),
        ),
        ),
      ),
      body:
      Center(
        child: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.blue, Colors.red])),
        child :new FutureBuilder<List<ForumCategory>>(
        future: fetchCountry(new http.Client()),
        builder: (context, snapshot) {
          print("hi");
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new CountyGridView(country: snapshot.data)
              : new Center(child: new CircularProgressIndicator());
        },
      ),
    ),
    ),
    );
  }
}
