
class ForumUser {

  String id_user;
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


  ForumUser();

  ForumUser.fromJsonMap(Map<String, dynamic> map):
        id_user = map["id_user"],
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
    data['id_user'] = id_user;
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

  String get id => id_user;

  set id(String value) {
    id_user = value;
  }


}
