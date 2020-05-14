import 'dart:convert';

import 'package:geeks_overflow/views/var.dart';
import 'package:http/http.dart';

class StreamKeyService {

  Future<dynamic> getUserStreamKey(String id) async
  {
    Response res = await get(Var.link+"/user/streamKey?user="+id);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    }
    else
    {
      throw "Can't get users.";
    }
  }

  Future<dynamic> resetUserStreamKey(String id) async
  {
    Response res = await post(Var.link+"/user/resetStreamKey", headers: {"Content-Type": "application/json"}, body: jsonEncode({"user": id}));
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