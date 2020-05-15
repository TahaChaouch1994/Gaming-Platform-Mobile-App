

import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/ForumCategory.dart';


import 'ListThreadsanddetail/ThreadsDashboard.dart';




class subreddistslist extends StatelessWidget {

  final ForumCategory user;

  subreddistslist(this.user);

  @override
  Widget build(BuildContext context) {
    if(user.lissubreddit == null){
      return Scaffold(


          backgroundColor: Colors.white,
          appBar: new AppBar(
            title: new Text(user.NameCategory,
              style: new TextStyle(
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),

body:


          Center(
            child: Container(




                child: Text("no subreddits added by admins"),
              )
          )



      );

    }
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(user.NameCategory,
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

      child :

      ListView.builder(

        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 80),
        itemCount: user.lissubreddit.length,

        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,



            child: Card(
              color: Colors.black26,
              child: ListTile(
                onTap: () {

                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new BookDashboard(user.lissubreddit[index].id,user.lissubreddit[index].Name,user.lissubreddit[index],user.id)),
                  );
                },
                title: Text(user.lissubreddit[index].Name,style: TextStyle(color: Colors.white),),
                subtitle: Text(user.lissubreddit[index].description,style: TextStyle(color: Colors.lightBlue),),
                leading: Stack(
                  children: <Widget>[

                    Container(
                      child: Text(
                        user.lissubreddit[index].Name[0].toUpperCase(),style: TextStyle(color: Colors.blueAccent),


                      ),
                      width: 40,
                      height: 40,
                      alignment: Alignment(0, 0),
                    ),

                  ],
                ),

              ),
            ),
          );
        },
      ),

    ),
    ),);
  }



}


