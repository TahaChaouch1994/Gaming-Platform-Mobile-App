import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/ForumUser.dart';
import 'package:geeks_overflow/entities/Replys.dart';
import 'package:geeks_overflow/entities/Thread.dart';
import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/views/var.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'CustomAppBar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';



class BookDetailsPage extends StatefulWidget {


  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();

  final Thread books;
  const BookDetailsPage(this.books);
}




class _BookDetailsPageState extends State<BookDetailsPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController c = TextEditingController();
  TextEditingController z = TextEditingController();
  Color color = Color(0xff59c2ff);

  String img =
      "https://i.pinimg.com/originals/77/d6/79/77d679bb5ba328796061202510f30bf2.jpg";

  User loggedInUser ;



  static final String addreply = Var.link+"/reply/add";




  Future<SharedPreferences> _prefs;
  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));
        this.loggedInUser = User.fromJsonMap(text);
      });
    });
    super.initState();
  }










  Future<List<Replys>> _replys() async {

    List<Replys> bookdetails = [];
    var data =await http.get(Var.link+"/replys/get?id="+widget.books.id);
    var jsonData = json.decode(data.body);
    for (var bookval in jsonData) {
      var id = bookval['_id'];

      var send = bookval["sender"]["username"];

      var idsend = bookval["sender"]["id_user"];
      var desc = bookval["content"];
      var like = bookval['likes'];
      var rept = bookval['replytime'];

      DateTime myDatetime = DateTime.parse(rept);
      String repdate = myDatetime.day.toString() +"/"+ myDatetime.month.toString()+ " /" + myDatetime.year.toString() + " -" + myDatetime.hour.toString() + " :" + myDatetime.minute.toString();



      Replys book = new Replys();


      book.id=id;

       book.threadid = widget.books.id;
      book.senderid = idsend;
      book.sender=send;

      book.likes=like;
      book.content=desc;

      book.replytime = repdate;


      bookdetails.add(book);

    }

    return bookdetails;
  }


  @override
  Widget build(BuildContext context) {
    String _text = "initial";

    List<Replys> repl = [];

      _replys().then((result) {

      print(result);
      print (result.length);
      for (var p in result)
        {

          repl.add(p);
        }
      repl = result;

    });

    print("this is lenght" + repl.length.toString());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: new AppBar(
        title: new Text(widget.books.title,
          style: new TextStyle(
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[

            Column(
              children: <Widget>[


                SizedBox(height: 2),
                Flexible(
                  flex: 1,
                  child: LayoutBuilder(
                    builder: (BuildContext c, BoxConstraints constraints) {
                      return ListView(
                        padding: const EdgeInsets.only(left: 20),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _buildItem(width, constraints),
                          SizedBox(width: 450),

                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 5),
                Flexible(
                  flex: 1,
                  child: LayoutBuilder(
                      builder: (BuildContext c, BoxConstraints constraints) {

                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10),
                              Text(
                                "Replys",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              Expanded(

                                child: Container(

                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth,

                                    child: FutureBuilder(
                                    builder: (context, projectSnap) {
                              if (projectSnap.connectionState == ConnectionState.none &&
                              projectSnap.hasData == null) {
                              print('project snapshot data is: ${projectSnap.data}');
                              return Container(child: Text("loading"),);
                              }
                              return ListView.builder(
                              itemCount: projectSnap.data.length,
                              itemBuilder: (context, index) {
                              Replys project = projectSnap.data[index];
                              return Column(
                              children: <Widget>[
                              _buildRecommendItem(constraints , project),
                              ],
                              );
                              },
                              );
                              },
                                future: _replys(),
                              )
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(height: 1),
              ],
            ),

          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },

                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: new InputDecoration(hintText: "Update Info"),
                                controller: c,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  ForumUser u = new ForumUser();
                                  u.username = this.loggedInUser.username;
                                  u.id = this.loggedInUser.id;
                                  u.email =this.loggedInUser.email;
                                  u.password = this.loggedInUser.password;
                                  u.firstName =  this.loggedInUser.firstName;
                                  u.lastName =  this.loggedInUser.lastName;
                                  u.dob = this.loggedInUser.dob;
                                  u.role = this.loggedInUser.role;
                                  u.status= this.loggedInUser.status;
                                  u.activity = "pog";
                                  u.lastActive = "pog";
                                  Replys rep = new Replys();
                                  rep.user = u;
                                  rep.content = c.text ;
                                  var now = new DateTime.now();
                                  rep.replytime = now.toString();
                                  rep.threadid = widget.books.id;
                                  rep.likes = 0;

                                  return http.post(
                                    addreply,
                                    headers: <String, String>{
                                      'Content-Type': 'application/json; charset=UTF-8',
                                    },
                                    body: jsonEncode(<String, dynamic>{
                                      'content': rep.content ,
                                      'replytime' : rep.replytime,
                                      'sender' :u,
                                      'likes' : 0 ,
                                      'threadid' :rep.threadid,

                                    }),
                                  ).then((res) {
                                    print(res.body);

                                  }).catchError((err) {
                                    print(err);
                                  });

                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );

              });
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

   _buildRecommendItem(BoxConstraints constraints , Replys p ) {
    double height = constraints.maxHeight * .60;

    return Container(
      height: height,
      width: constraints.maxWidth,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 12,
            top: 10,
            width: constraints.maxWidth - 70,
            height: height ,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: constraints.maxWidth * .1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    //boxShadow: shadow1,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.3,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.only(right: 8),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: new NetworkImage(Var.link+"/avatars/"+p.senderid+".jpg"),
                          ),
                          title: RichText(
                            text: new TextSpan(

                              children: <TextSpan>[
                                new TextSpan(
                                  text: p.sender,
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            p.replytime.toString(),
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),

                          subtitle: Text(
                            p.content,

                          ),
                        ),
                      ),
                      SizedBox(height: 1),
                    ],
                  ),
                ),
                Positioned(
                  right: 30,
                  top: 12,
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xffff8993),
                    size: 18,
                  ),

                ),
                Positioned(
                  right: 16,
                  top: 15,
                  child: Text(
                      p.likes.toString()
                  ),

                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Container _buildItem(double width, BoxConstraints constraints) {
    print(widget.books);
    return Container(
      width: width - 40,
      child: Builder(builder: (context) {
        return GestureDetector(

          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                width: width - 35,
                height: constraints.maxHeight * .70,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(Var.link+"/thread_attachements/"+widget.books.id+".jpg"),
                    ),
                  ),
                ),
              ),
              Positioned(

                width: width - 45,
                top: 120,
                height: constraints.maxHeight * .60,
                child: Padding(
                  padding: const EdgeInsets.all(10),

                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                          //boxShadow: shadow1,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey,

                                  backgroundImage: new NetworkImage(Var.link+"/avatars/"+widget.books.senderid+".jpg"),
                                ),
                                title: RichText(
                                  text: new TextSpan(
                                    text: 'by ',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: widget.books.user.username,
                                        style: new TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Text(
                                  "Title :" + widget.books.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ),
                            ),
                            Expanded(
                              child: ListTile(

                                title: Text(
                                   "description : " ),
                                subtitle: Text(
                                    widget.books.description
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 25,
                        top: 10,
                        child: Icon(
                          Icons.favorite,
                          color: Color(0xffff8993),
                        ),

                      ),
                      Positioned(
                        right: 14,
                        top: 15,
                        child: Text(
                            widget.books.likes
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

}

