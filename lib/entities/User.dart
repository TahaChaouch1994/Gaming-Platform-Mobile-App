
class User {

  String _id;
  String email;
  String username;
  String password;
  String dob;
  String role;
  String status;
  String firstName;
  String lastName;
  String lastActive;
  String activity;

	User.fromJsonMap(Map<String, dynamic> map): 
		_id = map["_id"],
		email = map["email"],
		username = map["username"],
		password = map["password"],
		dob = map["dob"],
		role = map["role"],
		status = map["status"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		lastActive = map["lastActive"],
		activity = map["activity"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = _id;
		data['email'] = email;
		data['username'] = username;
		data['password'] = password;
		data['dob'] = dob;
		data['role'] = role;
		data['status'] = status;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['lastActive'] = lastActive;
		data['activity'] = activity;
		return data;
	}

	String get id => _id;

	set id(String value) {
		_id = value;
	}

	User();
}
