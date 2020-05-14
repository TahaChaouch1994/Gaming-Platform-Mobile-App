
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeks_overflow/entities/Cart.dart';
import 'package:geeks_overflow/entities/Merch.dart';
import 'package:geeks_overflow/services/CartService.dart';
import 'package:geeks_overflow/services/MerchService.dart';
import 'package:geeks_overflow/views/var.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
{
  CartService cartService = new CartService();
  MerchService merchService = new MerchService();
  Cart cart = new Cart();
  List<TextEditingController> _controllers = new List();

  @override
  void initState() {
    super.initState();
    cartService.getCart().then((value) {
      setState(() {
        cart = value;
      });
    });
  }

  Widget cartWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.hasData == true)
           {
             return ListView.builder(
               scrollDirection: Axis.vertical,
               shrinkWrap: true,
               itemCount: projectSnap.data.length,
               itemBuilder: (BuildContext context, int index) {
                 Merch merch = projectSnap.data[index];
                 print(merch.name + " : " + cart.cart.values.elementAt(index).toString());
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
                         subtitle: Text("Quantity Wanted: " + cart.cart.values.elementAt(index).toString() + " | Final Price: " + (merch.price * cart.cart.values.elementAt(index)).toString() + " ESD"),
                       ),
                       new RaisedButton(
                         child: new Text("Remove"),
                         textColor: Colors.white,
                         color: Colors.red,
                         onPressed: () {
                           setState(() {
                             FocusScope.of(context).requestFocus(new FocusNode());
                             cartService.removeFromCart(merch);
                             cartService.getCart().then((value) {
                               setState(() {
                                 cart = value;
                               });
                             });
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
      future: merchService.getMerchFromCart(cart),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Proceed to confirmation"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            cartWidget(),
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.fromLTRB(350, 0, 350, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Address"
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "City"
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "ZIP Code"
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Phone Number"
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Notes"
                      ),
                    ),
                    _getActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}