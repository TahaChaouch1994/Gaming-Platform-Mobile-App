import 'package:flutter/material.dart';
import 'package:geeks_overflow/views/tournament/myaccepteddetail.dart';
import 'package:geeks_overflow/views/var.dart';
import 'package:http/http.dart';
import 'dart:convert';



class MyTournament extends StatefulWidget {
  @override
  _MyTournamentState createState() => _MyTournamentState();


  const MyTournament();

}





class _MyTournamentState extends State<MyTournament> {



  String test,test2;
  String tournamentname;
  String date;
  List tournaments,tournaments2,test3;
  String tournamentid;
  String iduser= '5e4a89793d2c1f100cc86574';
  String tournamentcode;
  int tester= 0;

  Future getData() async {
    Response response = await get(Var.link+'/tournament/mytournaments/$iduser');
    tournaments = jsonDecode(response.body) ;
    print(tournaments.length);
    getData2();
  }




  Future getData2() async {

    Response response2 = await get(Var.link+'/tournament/newtournament/$iduser');
    tournaments2 = jsonDecode(response2.body) ;
  }


  Future JoinTournament(code) async {
    Response response3 = await get(Var.link+'/tournament/gettournamentbycode/$code');
    test3=jsonDecode(response3.body) ;

    if(test3.length >0 )
      {
        Navigator.pushNamed(context, '/myaccepted' , arguments: {
          'tournament' : test3[0],
        });
      }
  }


  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {});
     getData();
    getData2();
  }



Widget makeBottom() {
  return Container(
    height: 55.0,
    child: BottomAppBar(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.blur_on, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/');
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



  Future<void> _neverSatisfied() async {
    return showDialog(
        context: context,

        builder: (context) {
          return AlertDialog(


            title: Text('Private Tournament Code'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Tournament Code"),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor:Colors.white ,

            actions: <Widget>[
              new FlatButton(
                child: new Text('Join Now'),
                color: Color.fromRGBO(58, 66, 86, 1.0),
                onPressed: () {
                 // Navigator.of(context).pop();
                  tournamentcode = _textFieldController.text;
                  JoinTournament(tournamentcode);

                },
              )
            ],
          );
        });
  }








  Widget tournamentTemplate2(name,date,time,etat,tournament){

    Color tester;

    if(etat == '1')
        tester= Colors.black;

    else if(etat == '2')
        tester = Colors.green;

    else
        tester = Colors.red;





    return Card(


      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
               contentPadding:


               EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
               leading: Container(

                 padding: EdgeInsets.only(right: 12.0),
                 decoration: new BoxDecoration(
                     border: new Border(
                         right: new BorderSide(width: 1.0, color: Colors.black))),
                 child: Icon(Icons.info, color: tester),
               ),
               title: Text(
                 name,
                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
               ),


               subtitle: Row(
                 children: <Widget>[
                   Expanded(
                       flex: 1,
                       child: Container(
                         // tag: 'hero',
                         child: LinearProgressIndicator(
                             backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                             value: 5,
                             valueColor: AlwaysStoppedAnimation(tester)),
                       )),
                   Expanded(
                     flex: 4,
                     child: Padding(
                         padding: EdgeInsets.only(left: 10.0),
                         child: Text(date +' '+ time,
                             style: TextStyle(color: Colors.black))),
                   )
                 ],
               ),
               trailing:
               Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
               onTap: () {
                 Navigator.pushNamed(context, '/tournamentdetail' , arguments: {
                   'tournament' : tournament,
                 });
               },


            ),
          ],
        ),
      ),
    );
  }





  Widget  tournamentTemplate3(name,date,time,tournament){


    return Card(

      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),

      child: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(

                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.black))),
                child: Icon(Icons.ac_unit, color: Colors.blue),
              ),
              title: Text(
                name,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),


              subtitle: Row(

                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        // tag: 'hero',
                        child: LinearProgressIndicator(
                            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                            value: 5,
                            valueColor: AlwaysStoppedAnimation(Colors.blue)),
                      )),
                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(date +' '+ time,
                            style: TextStyle(color: Colors.black))),
                  )
                ],
              ),
              trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
              onTap: () {
               Navigator.pushNamed(context,'/myaccepteddetail', arguments: {
                  'tournament' : tournament,
                });

              },


            ),
          ],
        ),
      ),
    );
  }




  Widget  testText()
  {
    return Text("looool");
  }


  @override
  Widget build(BuildContext context) {


    setState(() {});
    getData2();
    getData();

   return  FutureBuilder(
        future: getData(),
        builder: (context, snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none :
              return Text('');
            case ConnectionState.waiting :
              return Text('Loading');

            case ConnectionState.done :
              return Scaffold(


                backgroundColor:  Color.fromRGBO(50, 60, 80, 1.0),
                /*  appBar: AppBar(
        title: Text('My Tournaments'),
        centerTitle: true,
        backgroundColor:  Color.fromRGBO(58, 66, 86, 1.0),
      ),

     */
                body: SingleChildScrollView(
                  child :
                  Column(
                    children: <Widget>[







                      if(tournaments2 !=null)

                        for(int j = 0; j < tournaments2.length; j++)
                          tournamentTemplate3(tournaments2[j]['tournamentname'],
                              tournaments2[0]['newtournament'][j]['startdate'],
                              tournaments2[0]['newtournament'][j]['starttime'],
                              tournaments2[j]),




                      if(tournaments !=null)
                        for(int i = 0; i < tournaments.length; i++)
                          tournamentTemplate2(
                              tournaments[i]['tournamentname'], tournaments[i]['startdate'],
                              tournaments[i]['starttime'], tournaments[i]['etatTournoi'],
                              tournaments[i]),





                    ],


                  ),
                ),
                //  bottomNavigationBar: makeBottom(),

                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    _neverSatisfied();
                    //(context as Element).reassemble();
                    /* setState(() {

          });*/
                  },
                  label: Text('Join'),
                  icon: Icon(Icons.arrow_forward),
                  backgroundColor: Colors.pink,
                ),

              );
            default:
              return Text('');
          }
        }
    );



  }
}