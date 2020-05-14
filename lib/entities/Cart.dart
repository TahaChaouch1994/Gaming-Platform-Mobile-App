import 'dart:convert';

class Cart {
  String _id;
  Map<String, int> cart;

  Cart.fromJsonMap(Map<String, dynamic> map):
        _id = map["_id"],
        cart = jsonDecode(map["cart"]);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = _id;
    data['cart'] = cart;
    return data;
  }

  Cart()
  {
    this.cart = new Map<String, int>();
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}