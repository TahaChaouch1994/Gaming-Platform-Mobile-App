import 'dart:convert';

import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/views/var.dart';
import 'package:http/http.dart';

class WalletService {

  Future<dynamic> getUserWallet(String id) async
  {
    Response res = await get(Var.link+"/user/hasWallet?id="+id);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    }
  }

  Future<dynamic> createWallet(User user) async
  {
    Response res = await post(Var.link+"/user/createWallet", headers: {"Content-Type": "application/json"}, body: jsonEncode({"user": user.id}));
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    }
  }

  Future<dynamic> deleteWallet(String id) async
  {
    Response res = await delete(Var.link+"/user/unlinkAccount?user="+id);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    }
  }

  Future<dynamic> importWallet(User user, String key) async
  {
    Response res = await post(Var.link+"/user/privateKeyToAccount", headers: {"Content-Type": "application/json"}, body: jsonEncode({"user": user.id, "key": key}));
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    }
  }

}