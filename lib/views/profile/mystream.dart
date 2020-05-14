import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/services/StreamKeyService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStreamKeyScreen extends StatefulWidget {
  @override
  _MyStreamKeyScreenState createState() => _MyStreamKeyScreenState();

  const MyStreamKeyScreen();
}

class _MyStreamKeyScreenState extends State<MyStreamKeyScreen>
{
  Future<SharedPreferences> _prefs;
  User loggedInUser;
  StreamKeyService _streamKeyService = new StreamKeyService();
  TextEditingController keyCntrlr = new TextEditingController();
  bool _isHidden = true;

  void getStreamKeyData()
  {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));
      this.loggedInUser = User.fromJsonMap(text);
      this._streamKeyService.getUserStreamKey(loggedInUser.id).then((value) {
        print(value);
        keyCntrlr.text = value["streamKey"];
      });
    });
  }

  @override
  void initState() {
    getStreamKeyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: keyCntrlr,
                obscureText: _isHidden,
                readOnly: true,
                decoration: InputDecoration(
                    hintText: "Password"
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(5),
                    child: new RaisedButton(
                      child: new Text("Show"),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _isHidden = !_isHidden;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: new RaisedButton(
                      child: new Text("Copy"),
                      textColor: Colors.white,
                      color: Colors.orangeAccent,
                      onPressed: () {
                        setState(() {
                          Clipboard.setData(ClipboardData(text: keyCntrlr.text));
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: new RaisedButton(
                      child: new Text("Reset"),
                      textColor: Colors.white,
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          this._streamKeyService.resetUserStreamKey(loggedInUser.id).then((value) {
                            this.getStreamKeyData();
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}