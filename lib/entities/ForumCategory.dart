
import 'package:flutter/foundation.dart';

class ForumCategory {

  String id;
  String NameCategory;
  List<subreddist> lissubreddit;
  String image ;

  ForumCategory({this.id, this.NameCategory,this.image});

  factory ForumCategory.fromJson(Map<String, dynamic> json) {
    return new ForumCategory(
      id: json['_id'] as String,
      NameCategory: json['NameCategory'] as String,




    );
  }
}


class subreddist {

  String id;
  String description ;
  String Name ;
  String idcateg;

  subreddist({this.id, this.description, this.Name, String idcateg});




  factory subreddist.fromJson(Map<String, dynamic> json) {
    return new subreddist(
      id: json['_id'] as String,
      description: json['Description'] as String,
      Name:json['TopicName'] as String,
      idcateg:json['idCategory'] as String
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['Description'] = description;
    data['TopicName'] = Name;
    data['idCategory'] = idcateg ;

    return data;
  }

}
