import 'package:flutter/material.dart';
import 'package:geeks_overflow/views/profile/mystream.dart';
import 'package:geeks_overflow/views/profile/mywallet.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();

  const InfoScreen();
}

class _InfoScreenState extends State<InfoScreen>
{
  String _whichWidget = "streamkey";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print("stream key");
                      this._whichWidget = "streamkey";
                    });
                  },
                  child: Container(
                    child: Text("Stream key"),
                    padding: EdgeInsets.all(50.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print("wallet");
                      this._whichWidget = "wallet";
                    });
                  },
                  child: Container(
                    child: Text("Wallet"),
                    padding: EdgeInsets.all(50.0),
                  ),
                ),
              ],
            ),
          ),
          if (_whichWidget == "streamkey") Expanded(
            flex: 8,
            child: new MyStreamKeyScreen(),
          ),
          if (_whichWidget == "wallet") Expanded(
            flex: 8,
            child: new MyWalletScreen(),
          ),
        ],
      )
    );
  }

}