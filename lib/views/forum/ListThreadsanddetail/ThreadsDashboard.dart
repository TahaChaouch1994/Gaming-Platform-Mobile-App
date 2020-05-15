import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/ForumCategory.dart';
import 'package:geeks_overflow/entities/Thread.dart';
import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/views/forum/ListThreadsanddetail/AddThread.dart';
import 'package:geeks_overflow/views/var.dart';



import 'CustomAppBar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ThreadDetails.dart';


class BookDashboard extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String user;
  final String title;
  final subreddist subea ;

  final String idc ;
  BookDashboard(this.user,this.title,this.subea, this.idc);

  String _text = "initial";

  TextEditingController c = new TextEditingController();
  TextEditingController z  = new TextEditingController();














  Future<List<Thread>> _bookDetails() async {
    List<Thread> bookdetails = [];
    var data =await http.get(Var.link+"/thread/get?id="+subea.id);
    var jsonData = json.decode(data.body);
    print(jsonData);
    for (var bookval in jsonData) {
      print(bookval);
      var id = bookval['_id'];
      var send = bookval["sender"]["username"];
      var idsend = bookval["sender"]["id_user"];
      var title = bookval["title"];
      var desc = bookval["description"];
     var like = bookval['likes'];
     var dislike =  bookval['dislikes'];
     var add = bookval['addtime'];
      User us = new User();
      us.username = bookval["sender"]["username"];
      us.id = bookval["sender"]["id_user"];
      us.email = bookval["sender"]["email"];
      var sub = user;



      Thread book = new Thread();
      book.description=desc;

      book.id=id;

      book.user = us;
      book.title=title;
      book.senderid = idsend;
      book.sender=send;
       book.adddate = add;
      book.likes=like;
      print(book.likes);


      book.redditid=sub;
      book.subre = subea;
      book.subre.idcateg = idc ;
      bookdetails.add(book);

    }
    print(bookdetails.length);
    return bookdetails;
  }

  @override
  Widget build(BuildContext context) {
    print(idc);
    return Scaffold(
      appBar: new AppBar(
        title: new Text(title,
          style: new TextStyle(
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[


              FutureBuilder(
                future: _bookDetails(),

                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data.toString());

                  if (snapshot.data != null) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      color: Color(0xfffF7F7F7),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BookDetails(
                              snapshot.data[index],
                              snapshot.data[index].title,
                              snapshot.data[index].description,

                              snapshot.data[index].likes,
                              snapshot.data[index].sender,
                              );
                        },
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.blue, Colors.red])),
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,

            new MaterialPageRoute(builder: (context) => new UploadImageDemo(subea)),
            //new MaterialPageRoute(builder: (context) => new NewsAppConceptHome()),
          );
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
