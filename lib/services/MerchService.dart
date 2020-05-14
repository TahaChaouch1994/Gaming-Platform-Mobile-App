import 'dart:convert';

import 'package:geeks_overflow/entities/Cart.dart';
import 'package:geeks_overflow/entities/Merch.dart';
import 'package:geeks_overflow/views/var.dart';
import 'package:http/http.dart';

class MerchService {

  Future<List<Merch>> getUserMerch(String id) async
  {
    Response res = await get(Var.link + "/merch/list?user=" + id);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      List<Merch> merchs = new List();
      for (var item in body) {
        Merch m = Merch.fromJsonMap(item);
        merchs.add(m);
      }
      return merchs;
    }
    else {
      throw "Can't get users.";
    }
  }

  Future<List<Merch>> getMerchFromCart(Cart cart) async
  {
    Response res = await post(Var.link + "/cart/getMerchs", headers: {"Content-Type": "application/json"}, body: jsonEncode({"list": jsonEncode(cart.cart)}));
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      List<Merch> merchs = new List();
      for (var item in body) {
        Merch m = Merch.fromJsonMap(item);
        merchs.add(m);
      }
      return merchs;
    }
    else {
      throw "Can't get users.";
    }
  }

}