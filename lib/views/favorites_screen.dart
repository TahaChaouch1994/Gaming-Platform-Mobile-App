
import 'package:flutter/material.dart';
import 'package:geeks_overflow/services/http.dart';

class favorites_screen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}
class follow
{
  String receiver;
  String sender;
  String idfollow;
  follow(this.idfollow, this.sender,this.receiver);
}
class MainPageState extends State<favorites_screen>
{
  List<follow> users = [];
  Future<void> refreshUsers()async{
    var result = await http_get('follow/list/');
      setState(() {
        users.clear();
        var in_users = result.data as List<dynamic>;
        in_users.forEach((in_user){
          users.add(follow(
              in_user['idfollow'].toString(),
              in_user['idfollower'].toString(),
            in_user['iduser'].toString(),

          ));
        });
      });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: <Widget>[
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshUsers,
        child: ListView.separated(
          itemCount: users.length,
          itemBuilder: (context, i) => ListTile(
            leading: Icon(Icons.person),
            title: Text(users[i].receiver),
          ),
          separatorBuilder: (context, i) => Divider(),
        ),
      ),
    );
  }
}
