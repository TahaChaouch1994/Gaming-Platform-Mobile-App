import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';



  Map  data ={};

  String tournamentname;
  int numberx ,testn;

  List tournaments2;







class MyAcceptedDetail extends StatefulWidget {
  @override
  _MyAcceptedDetailState createState() => _MyAcceptedDetailState();
 /* final String data;

  MyAcceptedDetail({
    Key key,
    @required this.data,
  }) : super(key: key); */
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


Future getData2() async {

  Response response2 = await get('http://10.0.2.2:3005/tournament/getBracketPlayers/'+ data['tournament']['newtournament'][0]['_id']);
  tournaments2 = jsonDecode(response2.body) ;
}


class _MyAcceptedDetailState extends State<MyAcceptedDetail> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    data = (ModalRoute.of(context).settings.arguments);
    testn=numberx;
    getData2();


    return Scaffold(
      backgroundColor:  Color.fromRGBO(50, 60, 80, 1.0),
    /*  appBar: AppBar(
        title: Text(data['tournament']['tournamentname']),
        centerTitle: true,
        backgroundColor:  Color.fromRGBO(58, 66, 86, 1.0),
      ),
      bottomNavigationBar: makeBottom(context), */
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
                data['tournament']['newtournament'][0]['type'],
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
                data['tournament']['newtournament'][0]['gameregion'],
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
                data['tournament']['newtournament'][0]['startdate'] + ' ' +data['tournament']['newtournament'][0]['starttime'] ,
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
                data['tournament']['newtournament'][0]['gamemap']  ,
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
                data['tournament']['newtournament'][0]['gameformat'] ,
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
                data['tournament']['newtournament'][0]['entry'] ,
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
                data['tournament']['newtournament'][0]['entryfee'] ,
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
                data['tournament']['newtournament'][0]['tournamentfee'] ,
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
                data['tournament']['newtournament'][0]['minteams'] ,
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
                data['tournament']['newtournament'][0]['maxteams'] ,
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
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/bracket' , arguments: {
            'bracket' : tournaments2,
          });
        },
        label: Text('Bracket'),
        icon: Icon(Icons.device_hub),
        backgroundColor: Colors.grey,
      ),

    );

  }
}
