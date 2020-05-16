import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


class MyAccepted extends StatefulWidget {
  @override
  _MyAcceptedState createState() => _MyAcceptedState();
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



class _MyAcceptedState extends State<MyAccepted> {

  Map  data ={};
  String tournamentname;
  int test4;
  int numberx ,testn;

  List test3;

  String iduser= '5e4a89793d2c1f100cc86574';

  String firstpublickey=  '0xe07657d21E49E74b38CD0B0F7eD9d032C99fB7bf';
  String firstprivatekey= '7E465C95AF3B3741772865424973398A9A02A7680EADACD89CDC4ACD22A907B9';
  String secondpublickey= '0xb1103661bA1736EC0C83931ce12851158b62875d';


  Future getData() async {
    Response response = await get('http://10.0.2.2:3005/tournament/numberofplacesroomtournament/'+ data['tournament']['tournamentname']);
    numberx = jsonDecode(response.body) ;

    if(data['tournament']['createtype'] == "spectator")
      numberx ++;

    tournamentname = data['tournament']['tournamentname'];
    print(numberx);

    await CheckJoined();
  }



  Future JoinTournament() async {
    Response response3 = await get('http://10.0.2.2:3005/tournament/jointournament/$iduser/$tournamentname');
    test3=jsonDecode(response3.body) ;

    await PayTournament();

  }

  Future PayTournament() async {
    Response response4 = await get('http://10.0.2.2:3005/transaction/$firstpublickey/$firstprivatekey/$secondpublickey/'+data['tournament']['entryfee']);
  }


  Future CheckJoined() async {
    Response response4 = await get('http://10.0.2.2:3005/tournament/checkjoined/$tournamentname/$iduser');
    test4=jsonDecode(response4.body) ;
    print( "check joined : " + test4.toString());

  }




  Future<void> Joining() async {
    return showDialog(
        context: context,

        builder: (context) {
          return AlertDialog(


            title: Text('By Joining this Tournament You will Pay ' + data['tournament']['entryfee'] +' ESD'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor:Colors.white ,

            actions: <Widget>[
              new FlatButton(
                child: new Text('Accept And Join'),
                color: Color.fromRGBO(58, 66, 86, 1.0),
                onPressed: () {
                  JoinTournament();
                  Navigator.of(context).pop();
                  success();
                  setState(() {});
                },
              )
            ],
          );
        });
  }


  Future<void> success() async {
    return showDialog(
        context: context,

        builder: (context) {
          return AlertDialog(


            title: Text('You Successfully Joined ' + tournamentname +', Enjoy ! '),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor:Colors.white ,

            actions: <Widget>[
              new FlatButton(
                child: new Text('Thanks'),
                color: Color.fromRGBO(58, 66, 86, 1.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  Future<void> fail() async {
    return showDialog(
        context: context,

        builder: (context) {
          return AlertDialog(


            title: Text('You Already  Joined ' + tournamentname + ' .'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor:Colors.white ,

            actions: <Widget>[
              new FlatButton(
                child: new Text('Okey'),
                color: Color.fromRGBO(58, 66, 86, 1.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  @override
  void initState() {
    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {

    data = (ModalRoute.of(context).settings.arguments);
    getData();
    testn=numberx;


    return Scaffold(
      backgroundColor:  Color.fromRGBO(50, 60, 80, 1.0),
     /* appBar: AppBar(
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(test4>0)
            {
                fail();
            }
          else
            {
              Joining();
            }

        CheckJoined();
        },
        label: Text('Finish'),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: Colors.pink,
      ),
    );

  }
}
