
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeks_overflow/entities/Merch.dart';
import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/services/CartService.dart';
import 'package:geeks_overflow/services/MerchService.dart';
import 'package:geeks_overflow/views/var.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchScreen extends StatefulWidget {
  @override
  _MerchScreenState createState() => _MerchScreenState();
  MerchScreen({Key key, this.user}) : super(key: key);
  final User user;
}

class _MerchScreenState extends State<MerchScreen>
{

  List<Merch> merchs = new List();
  MerchService merchService = new MerchService();
  CartService cartService = new CartService();
  Future<SharedPreferences> _prefs;
  User loggedInUser;
  List<TextEditingController> _controllers = new List();

  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));
      this.loggedInUser = User.fromJsonMap(text);
    });
  }

  Widget merchWidgets() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        if (projectSnap.hasData == true)
          {
            return ListView.builder(
              itemCount: projectSnap.data.length,
              itemBuilder: (context, index) {
                _controllers.add(new TextEditingController());
                Merch merch = projectSnap.data[index];
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: new NetworkImage(
                              Var.link+"/user_merch/"+merch.id+".jpg"), // no matter how big it is, it won't overflow
                        ),
                        title: Text("Name: " + merch.name ),
                        subtitle: Text("Quantity Left: " + merch.quantity.toString() + " | Price: " + merch.price.toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(200, 0, 200, 0),
                        child: TextField(
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              hintText: "Quantity"
                          ),
                        ),
                      ),
                      new RaisedButton(
                        child: new Text("Buy"),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            cartService.addToCart(merch, int.parse(_controllers[index].text));
                          });
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      )
                    ],
                  ),
                );
              },
            );
          }
        return Container();
      },
      future: merchService.getUserMerch(widget.user.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username),
      ),
      body: merchWidgets()
    );
  }

  @override
  void dispose() {
    for (TextEditingController item in _controllers)
      {
        item.dispose();
      }
  }


}