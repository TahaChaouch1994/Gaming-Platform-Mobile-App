import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/ForumCategory.dart';
import 'package:geeks_overflow/services/ForumService.dart';
import 'package:geeks_overflow/views/cart/cart.dart';
import 'package:geeks_overflow/views/forum/ListSubreddits.dart';
import 'package:geeks_overflow/views/home/firstpage.dart';
import 'package:geeks_overflow/views/login/welcomePage.dart';
import 'package:geeks_overflow/views/profile/info.dart';
import 'package:geeks_overflow/views/profile/profile.dart';
import 'package:geeks_overflow/views/tournament/mytournaments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Choice {
  Choice(this.title, this.icon);

  String title;
  IconData icon;


}

List<Choice> choices = <Choice>[
  Choice('Logout', Icons.cancel),
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _selectedIndex = 0;
  Choice _selectedChoice = choices[0];
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    /*Text(
      'Index 0: Home',
      style: optionStyle,
    ),*/
    const FirstPageScreen(),

    new FutureBuilder<List<ForumCategory>>(
      future: fetchCountry(new http.Client()),
      builder: (context, snapshot) {
        print("hi");
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? new CountyGridView(country: snapshot.data)
            : new Center(child: new CircularProgressIndicator());
      },
    ),
    const InfoScreen(),
    const MyTournament(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    print(choice.title);
    if (choice.title == "Logout")
      {
        _prefs.then((SharedPreferences prefs) => {
          if (prefs.containsKey("go_user"))
            {
              prefs.remove("go_user"),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              )
            }
        });
      }
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProfileScreen())
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartScreen())
              );
            },
          ),
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Forums'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Tournament'),
          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),

    );
  }
}
