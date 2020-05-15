import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geeks_overflow/entities/Thread.dart';


import 'ThreadDetailsPage.dart';

class BookDetails extends StatelessWidget {
   Thread index;
   String bookname;
   String bookauthor;

   String bookrating;
   String bookviews;

BookDetails(this.index,this.bookname,this.bookauthor,this.bookrating,this.bookviews);

  @override
  Widget build(BuildContext context) {
    print(index.senderid);
    print("this was a test");


    return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Stack(
      children: <Widget>[
      Container(
        width: 220.0,
        height: 200.0,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          image: DecorationImage(

            image: new NetworkImage("http://192.168.1.4:1337/thread_attachements/"+index.id+".jpg"
          ),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Positioned(
        left: 100,
        top: 40.0,
        child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Container(
              width: 180.0,
              height: 140.0,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(

                      child: Center(

                          child: Text(bookname,
                              style: TextStyle(
                                  color: Color(0xff07128a),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    child: Center(
                        child: Text(bookauthor,
                            style: TextStyle(
                                color: Color(0xff2da9ef),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold))),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(bookviews.toString(),
                          style: TextStyle(
                              color: Color(0xffff6f00), fontSize: 16.0)),
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.angleRight,
                            color: Color(0xffff6f00),
                          ),
                          onPressed: () {
                              print("test index");
                              print (index.senderid);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetailsPage(index)));
                          }),
                    ],
                  )),
                ],
              ),
            )),
      ),
    ]),
  );
  }
}