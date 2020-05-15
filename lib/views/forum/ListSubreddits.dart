import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geeks_overflow/entities/ForumCategory.dart';



import 'Listreddits.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new CountyGridView());
  }
}
class CountyGridView extends StatelessWidget {
  final List<ForumCategory> country;

  CountyGridView({Key key, this.country}) : super(key: key);

  Card getStructuredGridCell(ForumCategory country,context) {

    return new Card(

        color: Colors.black26,

        elevation: 2.5,
        child: Container(

          child: InkWell(
            onTap: () {

              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new subreddistslist(country)),
                //new MaterialPageRoute(builder: (context) => new NewsAppConceptHome()),
              );
            },


          child: new Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,

            children: <Widget>[

              ClipPath(

                clipper: ArcClipper(),

                child: SizedBox(
                  width: 200,
                  height: 150,


                  child:
                  new Image.asset('assets/'+country.NameCategory.toLowerCase()+'.png', width: 100.0, height: 100.0)
                  ),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10.0),
                child:  Center(
                  child : new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[


                    new Text(country.NameCategory,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),

                  ],
                ),
              ),
              )
            ],
          )
          ),
        ),);
  }

  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      primary: true,
      crossAxisCount: 2,

      childAspectRatio: 0.80,
      children: List.generate(country.length, (index) {
        return getStructuredGridCell(country[index],context);
      }),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}