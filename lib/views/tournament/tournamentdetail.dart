import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';



class Tournamentdetail extends StatefulWidget {
  @override
  _TournamentdetailState createState() => _TournamentdetailState();
}


Widget makeBottom(context) {
  return Container(
    height: 55.0,
    child: BottomAppBar(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          IconButton(
            icon: Icon(Icons.blur_on, color: Colors.white),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.hotel, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_box, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
    ),
  );
}



class _TournamentdetailState extends State<Tournamentdetail> {


  Map  data ={};
  String tournamentname;
  int numberx ,testn;



  Future getData() async {
    Response response = await get('http://10.0.2.2:3005/tournament/numberofplacesroomtournament/'+ data['tournament']['tournamentname']);
    numberx = jsonDecode(response.body) ;

    if(data['tournament']['createtype'] == "spectator")
      numberx ++;


    print(numberx);


  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    data = (ModalRoute.of(context).settings.arguments);
    getData();
    testn=numberx;


    return Scaffold(
      backgroundColor:  Color.fromRGBO(50, 60, 80, 1.0),
  /*    appBar: AppBar(
        title: Text(data['tournament']['tournamentname']),
        centerTitle: true,
        backgroundColor:  Color.fromRGBO(58, 66, 86, 1.0),
      ), */
     // bottomNavigationBar: makeBottom(context),
      body:
      SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(
                'Type',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['type'],
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),

              Text(
                'Game Region',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['gameregion'],
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Start Date',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['startdate'] + ' ' +data['tournament']['starttime'] ,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),
              ////////
              Text(
                'Game Map',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['gamemap']  ,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Game Format',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['gameformat'] ,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Entry',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['entry'] ,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),

              Text(
                'Entry Fee',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['entryfee'] ,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),

              Text(
                'Tournament Fee',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['tournamentfee'] ,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),

              Text(
                'Min Teams',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['minteams'] ,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),

              Text(
                'Max Teams',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                data['tournament']['maxteams'] ,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),


            ],
          ),

        ),
      ),
    /*  floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Join'),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: Colors.pink,
      ),*/
    );

  }
}


