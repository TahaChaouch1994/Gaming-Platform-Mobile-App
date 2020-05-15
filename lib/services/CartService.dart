import 'dart:convert';

import 'package:geeks_overflow/entities/Cart.dart';
import 'package:geeks_overflow/entities/Merch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Cart> getCart() async
  {
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey("go_cart"))
      {
        var text = jsonDecode(prefs.get("go_cart"));
        Map<String, int> cart = Map.from(text["cart"]);
        String id = text["id"];
        Cart tempCart = new Cart();
        tempCart.id = id;
        tempCart.cart = cart;
        return tempCart;
      }
    else
      {
        return new Cart();
      }
  }

  void addToCart(Merch item, int qte) async
  {
    getCart().then((value) async
    {
      if (value.cart.containsKey(item.id))
      {
        value.cart[item.id] += qte;
      }
      else
      {
        value.cart[item.id] = qte;
      }
      final SharedPreferences prefs = await _prefs;
      prefs.setString("go_cart", jsonEncode(value)).then((bool success) {
        print(success);
      });
    });
  }

  void removeFromCart(Merch item) async
  {
    getCart().then((value) async
     {
       if (value.cart.containsKey(item.id))
       {
         value.cart.remove(item.id);
       }
       final SharedPreferences prefs = await _prefs;
       prefs.setString("go_cart", jsonEncode(value)).then((bool success) {
         print(success);
       });
     });
  }
}