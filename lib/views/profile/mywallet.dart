import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/services/WalletService.dart';
import 'package:geeks_overflow/utils/crypto.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class MyWalletScreen extends StatefulWidget {
  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();

  const MyWalletScreen();
}

class _MyWalletScreenState extends State<MyWalletScreen>
{
  String _whichScreen;
  String balance = "";
  String adr = "";
  Future<SharedPreferences> _prefs;
  User loggedInUser;
  TextEditingController walletPrivateKey = new TextEditingController();
  TextEditingController passwordCntrlr = new TextEditingController();
  WalletService walletService = new WalletService();
  bool _btnEnabler = false;

  void getWalletData()
  {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));
      this.loggedInUser = User.fromJsonMap(text);
      this.walletService.getUserWallet(this.loggedInUser.id).then((value) {
        setState(() {
          if (value == "None")
          {
            this._whichScreen = "first";
            this._btnEnabler = true;
          }
          else
          {
            this._whichScreen = "already";
            this.balance = value["balance"];
            this.adr = value["adr"];
            this._btnEnabler = false;
          }
        });
      });
    });
  }

  @override
  void initState() {
    getWalletData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_whichScreen == "first")  Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child:
            Column(
              children: <Widget>[
                Text("You can either choose to import your own wallet or create a new one"),
                _getActionButtons(),
              ],
            ),
          )
        ),
        if (_whichScreen == "already") Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Balance: " + this.balance + " ESD"),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Address: " + this.adr),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: new RaisedButton(
                  child: new Text("Unlink"),
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      this.walletService.deleteWallet(this.loggedInUser.id).then((value) {
                        print(value);
                        if (value == "fine")
                          {
                            getWalletData();
                          }
                      });
                      //print("did I just press the button?");
                    });
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                )
              ),
            ],
          ),
        ),
        if (_whichScreen == "import") Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: walletPrivateKey,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: new RaisedButton(
                        child: new Text("Back"),
                        textColor: Colors.white,
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            this._whichScreen = "first";
                          });
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: new RaisedButton(
                        child: new Text("Scan QR Code"),
                        textColor: Colors.white,
                        color: Colors.deepOrangeAccent,
                        onPressed: () async {
                          String cameraScanResult = await scanner.scan();
                          setState(() {
                            print(cameraScanResult);
                            walletPrivateKey.text = cameraScanResult;
                          });
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: new RaisedButton(
                        child: new Text("Import"),
                        textColor: Colors.white,
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            String privateKey = walletPrivateKey.text;
                            String encrypted = Crypto.encryptAESCryptoJS(privateKey, "6IAVE+56U5t7USZhb+9wCcqrTyJHqAu09j0t6fBngNo=");
                            print(encrypted);
                            walletService.importWallet(this.loggedInUser, encrypted).then((value) {
                              if (value == "fine")
                                {
                                  this.getWalletData();
                                }
                              else if (value == "Already used")
                                {
                                  Fluttertoast.showToast(
                                    msg: "This wallet is already associated with another account.",
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                }
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
        if (_whichScreen == "create") Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: passwordCntrlr,
                  obscureText: true,
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
                        child: new Text("Back"),
                        textColor: Colors.white,
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            this._whichScreen = "first";
                          });
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: new RaisedButton(
                        child: new Text("Create"),
                        textColor: Colors.white,
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            String typedPassword = passwordCntrlr.text;
                            String userPw = loggedInUser.password;
                            print(typedPassword);
                            print(userPw);
                            if (typedPassword != userPw)
                            {
                              Fluttertoast.showToast(
                                msg: "Passwords don't match.",
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                            else
                            {
                              this.walletService.createWallet(loggedInUser).then((value) {
                                String newKey = Crypto.decryptAESCryptoJS(value, "6IAVE+56U5t7USZhb+9wCcqrTyJHqAu09j0t6fBngNo=");
                                Clipboard.setData(ClipboardData(text: newKey));
                                Fluttertoast.showToast(
                                  msg: "Your new wallet's private key has been copied to your clipboard.",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                                this.getWalletData();
                              });
                            }
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
        )
      ],
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
                    child: new Text("Create"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _whichScreen = "create";
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Import"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        this._whichScreen = "import";
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
}