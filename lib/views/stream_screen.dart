

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/follow_model.dart';
import 'package:geeks_overflow/entities/stream_model.dart';
import 'package:geeks_overflow/services/http.dart';
import 'package:geeks_overflow/utils/circular_clipper.dart';
import 'package:geeks_overflow/views/chat_screen.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:video_player/video_player.dart';

enum Categories { OptionONE, OptionTWO, OptionTHREE }



class MovieScreen extends StatefulWidget {
  final stream movie;
  follow follows;

  MovieScreen({this.movie,this.follows});
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  VideoPlayerController _controller;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  String response = "";


  Future<Categories> _selectOptionDialog(BuildContext context) async {

    return await showDialog<Categories>(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
              title:  Container(
                alignment: Alignment.center,
                child: Text(
                  "SUBSCRIPTION",
                  style: TextStyle(color: Colors.redAccent, fontSize: 25),
                ),

              ),
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text('Subscriptions are a great way to directly support the streamers you love and get great benefits too!',
                      style: TextStyle(fontSize: 15))),
              SimpleDialogOption(
                child: DialogButton(
                  child: Text(
                    "ONE Month Subscriber |  \$4.99",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () =>   Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "warning",
                    desc: "Are you sure you want to buy your Pro subscription for one month",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => createsubscribe1(context),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                      ),
                      DialogButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(116, 116, 191, 1.0),
                          Color.fromRGBO(52, 138, 199, 1.0)
                        ]),
                      )
                    ],
                  ).show(),
                  color: Color.fromRGBO(200, 1, 30, 1.0),
                ),
              ),
              SimpleDialogOption(
                child: DialogButton(
                  child: Text(
                    "SIX Month Subscriber |  \$24.99",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () =>  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "warning",
                    desc: "Are you sure you want to buy your Pro subscription for six month",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => createsubscribe2(context),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                      ),
                      DialogButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(116, 116, 191, 1.0),
                          Color.fromRGBO(52, 138, 199, 1.0)
                        ]),
                      )
                    ],
                  ).show(),
                  color: Color.fromRGBO(200, 1, 30, 1.0),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {

                },
                child:DialogButton(
                  child: Text(
                    "ONE year Subscriber |  \$40.99",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () =>  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "warning",
                    desc: "Are you sure you want to buy your Pro subscription for one year ",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => createsubscribe3(context),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                      ),
                      DialogButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(116, 116, 191, 1.0),
                          Color.fromRGBO(52, 138, 199, 1.0)
                        ]),
                      )
                    ],
                  ).show(),
                  color: Color.fromRGBO(200, 1, 30, 1.0),
                ),
              ),
            ],
          );
        });
  }
  createfollow(context) async {
    var result = await http_post("profil/follow/", {
      "receiver":"med",
      "sender":"salem",

    });
    if(result.ok)
    {
      setState(() {
        response = result.data['status'];
      });
    }

    
  }
  createsubscribe1(context) async {
    var now = new DateTime.now();
    var dateex = now.add(new Duration(days: 30));

    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(dateex);
     var result = await http_post("profil/abonnement/", {
     "iduser" : "this.iduser",
     "idstreamer" : "this.idstreamer",
     "dateex" : formatted,
     "level" : "level 1",

    });
    if(result.ok)
    {
      setState(() {
        response = result.data['status'];
      });
    }
    return await Navigator.pop(context);
  }
  createsubscribe2(context) async {
    var now = new DateTime.now();
    var dateex = now.add(new Duration(days: 180));

    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(dateex);
    var result = await http_post("profil/abonnement/", {
      "iduser" : "this.iduser",
      "idstreamer" : "this.idstreamer",
      "dateex" : formatted,
      "level" : "level 1",

    });
    if(result.ok)
    {
      setState(() {
        response = result.data['status'];
      });
    }
   return await Navigator.pop(context);
  }
  createsubscribe3(context) async {
    var now = new DateTime.now();
    var dateex = now.add(new Duration(days: 365));

    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(dateex);
    var result = await http_post("profil/abonnement/", {
      "iduser" : "this.iduser",
      "idstreamer" : "this.idstreamer",
      "dateex" : formatted,
      "level" : "level 1",

    });
    if(result.ok)
    {
    setState(() {
        response = result.data['status'];
      });
    }
    return await Navigator.pop(context);
  }







  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..initialize().then((_) {});
    _videoPlayerController1 = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );


  }
  @override
  void dispose() {
    _controller.pause();
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _controller.value.isPlaying
                ? Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.pause();
                      _controller = VideoPlayerController.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
                        ..initialize().then((_) {});
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              ],
            )
                : ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      transform:
                      Matrix4.translationValues(0.0, -50.0, 0.0),
                      child: Hero(
                        tag: widget.movie.title,
                        child: ClipShadowPath(
                          clipper: CircularClipper(),
                          shadow: Shadow(blurRadius: 20.0),
                          child:Chewie(
                            controller: _chewieController,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.only(left: 30.0),
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30.0,
                          color: Colors.white,
                        ),
                        Image(
                          image: AssetImage('assets/images/title.jpg'),
                          height: 60.0,
                          width: 150.0,
                        ),
                        IconButton(
                          padding: EdgeInsets.only(left: 30.0),
                          onPressed: () => {},
                          icon: Icon(Icons.favorite_border),
                          iconSize: 30.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Positioned.fill(
                      bottom: 10.0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RawMaterialButton(
                          padding: EdgeInsets.all(10.0),
                          elevation: 12.0,
                          onPressed: () {
                            setState(() {
                              _controller.play();
                            });
                          },
                          shape: CircleBorder(),
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.play_arrow,
                            size: 60.0,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 20.0,
                      child: IconButton(
                        onPressed: () => createfollow(context),
                        icon: Icon(Icons.favorite),
                        iconSize: 40.0,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 25.0,
                      child: IconButton(
                        onPressed: () =>  _selectOptionDialog(context),
                        icon: Icon(Icons.subscriptions),
                        iconSize: 35.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 350,
                  width: 200,
                  child: ChatScreen(),

                ),
              ],
            ),
          ),
        ));
  }
}
