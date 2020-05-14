
class Merch
{

	String _id;
	String name;
	String description;
	double price;
	double quantity;
	String user;


	Merch.fromJsonMap(Map<String, dynamic> map): 
		_id = map["_id"],
		name = map["name"],
		description = map["description"],
		price = map["price"],
		quantity = map["quantity"],
		user = map["user"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = _id;
		data['name'] = name;
		data['description'] = description;
		data['price'] = price;
		data['quantity'] = quantity;
		data['user'] = user;
		return data;
	}

	String get id => _id;

	set id(String value) {
		_id = value;
	}


}
