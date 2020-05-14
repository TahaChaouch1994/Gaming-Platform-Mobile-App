import 'dart:convert';

import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/views/var.dart';
import 'package:http/http.dart';

class UserService {

  Future<dynamic> getUserFromLogin(String email, String password) async
  {
    Response res = await get(Var.link+"/user/login?login="+email+"&password="+password);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    }
  }

  Future<dynamic> registerNewUser(User user) async
  {
    Response res = await post(Var.link+"/user/register", headers: {"Content-Type": "application/json"}, body: jsonEncode(user));
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    }
  }

  Future<dynamic> updateUser(User user) async
  {
    Response res = await put(Var.link+"/user/update", headers: {"Content-Type": "application/json"}, body: jsonEncode(user));
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    }
  }

  Future<List<User>> findUser(String username) async
  {
    Response res = await get(
        Var.link + "/user/searchByUsername?username=" + username);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      List<User> users = new List();
      for (var item in body)
      {
        User user = User.fromJsonMap(item);
        users.add(user);
      }
      return users;
    }
    else {
      throw "Can't get users.";
    }
  }
}