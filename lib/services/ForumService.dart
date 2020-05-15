import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geeks_overflow/entities/ForumCategory.dart';
import 'package:geeks_overflow/entities/Replys.dart';
import 'package:geeks_overflow/entities/Thread.dart';
import 'package:geeks_overflow/views/var.dart';

import 'package:http/http.dart' as http;


Future<List<ForumCategory>> fetchCountry(http.Client client) async {
  final response = await client.get(Var.link+"/forum/categories");
  // Use the compute function to run parsePhotos in a separate isolate

  var  jsonData = json.decode(response.body);

  List<ForumCategory> categories = [];

  for (var u in jsonData)
  {
    ForumCategory c  = ForumCategory();
    c.id = u["_id"];
    List<subreddist> sub = [];
    c.NameCategory = u["NameCategory"];
    var m = u["reddiDetails"];
    for (var p in m )
    {
      if(p != null) {
        subreddist su = subreddist();
        su.description = p["Description"];
        su.Name=p["TopicName"];
        su.id=p["_id"];
        sub.add(su);
      }
      c.lissubreddit = sub;
    }

    categories.add(c);

  }
  print("hi");
  print(categories);
  print("hi");
  return (categories);

}

// A function that will convert a response body into a List<Country>
List<ForumCategory> parseData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<ForumCategory> list =
  parsed.map<ForumCategory>((json) => new ForumCategory.fromJson(json)).toList();

  return list;
}


Future<List<Thread>> _bookDetails(id) async {
  var data =await http.get(Var.link+"/thread/get?id="+id);
  var jsonData = json.decode(data.body);
  List<Thread> bookdetails = [];
  print(jsonData);
  for (var bookval in jsonData) {
    var id = bookval['_id'];
    var send = bookval['sender'];
    var title = bookval["title"];
    var desc = bookval["description"];
    var like = bookval['likes'];
    var dislike =  bookval['dislikes'];
    var sub = bookval['sender']['username'];
    var add  = bookval["addtime"];


    Thread book = new Thread();
    book.description=desc;
    book.id=id;
    book.title=title;
    book.sender=send["username"];

    book.likes=like;
    book.dislikes=dislike;
    book.redditid=sub;

    bookdetails.add(book);
  }
  print(bookdetails.length);
  return bookdetails;
}

Future<List<Replys>> _replys(id) async {
  List<Replys> bookdetails = [];
  var data =await http.get(Var.link+"/replys/get?id="+id);
  var jsonData = json.decode(data.body);
  for (var bookval in jsonData) {
    var id = bookval['_id'];

    var send = bookval["sender"]["username"];

    var idsend = bookval["sender"]["id_user"];
    var desc = bookval["content"];
    var like = bookval['likes'];






    Replys book = new Replys();


    book.id=id;

    book.threadid = id;
    book.senderid = idsend;
    book.sender=send;

    book.likes=like;
    book.content=desc;




    bookdetails.add(book);

  }

  return bookdetails;
}