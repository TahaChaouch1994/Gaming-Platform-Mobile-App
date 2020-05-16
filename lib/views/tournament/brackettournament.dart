import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

String Name1= "-",Name2= "-",Name3= "-",Name4= "-",Name5= "-",Name6= "-",Name7= "-",Name8= "-",Name9= "-",Name10= "-",Name11= "-",Name12= "-",Name13= "-",Name14 = "-";
Map  data ={};
Color winner13,winner14;



  testColors()
  {
    if(data.toString().length >= 600) {


        if(data['bracket'][3]['player1'].toString() ==  data['bracket'][4]['player1'].toString()) {
          winner13 = Colors.red;
          winner14 = Colors.green;
        }
        else
          {
            winner14 = Colors.red;
            winner13 = Colors.green;
          }
      }

  /*int test = data['bracket'][3]['player1'].toString().compareTo(data['bracket'][4]['player1'].toString());

  print(test);*/



  }



class bracketTournament extends StatefulWidget {
  @override
  _bracketTournamentState createState() => _bracketTournamentState();
}

class _bracketTournamentState extends State<bracketTournament> {

  @override
  Widget build(BuildContext context) {
    data = (ModalRoute.of(context).settings.arguments);
    testColors();
    print(data.length);

    Name1 =  data['bracket'][0]['player1'];
    Name4 =  data['bracket'][0]['player2'];
    Name5 =  data['bracket'][1]['player1'];
    Name8 =  data['bracket'][1]['player2'];
    Name9  = data['bracket'][0]['player1'];
    Name10 = data['bracket'][0]['player2'];
    Name11 = data['bracket'][1]['player1'];
    Name12 = data['bracket'][1]['player2'];


    if(data.toString().length >=300) {
      Name13 = data['bracket'][2]['player1'];
    }

    if(data.toString().length >= 450) {
      Name14 = data['bracket'][3]['player2'];
    }




    return Scaffold(
      backgroundColor:  Color.fromRGBO(50, 60, 80, 1.0),
   /*   appBar: AppBar(
        title: Text('Tournament Bracket'),
        centerTitle: true,
        backgroundColor:  Color.fromRGBO(58, 66, 86, 1.0),
      ), */
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        Center(
            child: Text(
              'QuarterFinals',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
        ),
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(8.8),
              child: Row(
                  children: <Widget>[
                    Text(
                      '$Name1',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                    SizedBox(width: 105),
                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      '$Name2',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.8),
              child: Row(
                  children: <Widget>[
                    Text(
                      '$Name3',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                    SizedBox(width: 155),
                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      '$Name4',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.8),
              child: Row(
                  children: <Widget>[
                    Text(
                      '$Name5',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                    SizedBox(width: 115),
                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      '$Name6',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.8),
              child: Row(
                  children: <Widget>[
                    Text(
                      '$Name7',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                    SizedBox(width: 155),
                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      '$Name8',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                  ]),
            ),



            ///SEMIFINAL///

            Divider(
              color: Colors.white70,
              height: 60.0,
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                'SemiFinals',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(8.8),
              child: Row(
                  children: <Widget>[
                    Text(
                      '$Name9',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                    SizedBox(width: 115),
                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      '$Name10',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.8),
              child: Row(
                  children: <Widget>[
                    Text(
                      '$Name11',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                    SizedBox(width: 128),
                    Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(width: 100),
                    Text(
                      '$Name12',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 2.0,
                      ),
                    ),

                  ]),
            ),







            //FINAL//
            Divider(
              color: Colors.white70,
              height: 60.0,
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                'Final',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            SizedBox(height: 40.0),

            Padding(
              padding: const EdgeInsets.all(8.8),
              child: Row(
                  children: <Widget>[
                    Text(
                      '$Name13',
                      style: TextStyle(
                        color: winner13,
                        letterSpacing: 2.0,
                      ),
                    ),

                    SizedBox(width: 115),
                     Text(
                        'VS',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                    SizedBox(width: 100),
                    Text(
                      '$Name14',
                      style: TextStyle(
                        color: winner14,
                        letterSpacing: 2.0,
                      ),
                    ),

              ]),
            )

    ])
    )
    );
  }
}





