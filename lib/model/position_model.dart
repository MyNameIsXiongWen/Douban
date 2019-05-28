import 'dart:convert';
//import 'package:meta/meta.dart';

class Position {
  final String name;
  final String companyName;
  final String size;
  final String salary;
  final String userName;
  final String title;
  final String avatar;

  Position({
//    @required this.name,
//    @required this.companyName,
//    @required this.size,
//    @required this.salary,
//    @required this.userName,
//    @required this.title,
//    @required this.avatar
    this.name,
    this.companyName,
    this.size,
    this.salary,
    this.userName,
    this.title,
    this.avatar
});


//  Position.fromJson(Map<String, dynamic> json)
//      : name = json['name'],
//        companyName = json['companyName'],
//        userName = json['userName'],
//        size = json['size'],
//        salary = json['salary'],
//        title = json['title'];

  static List<Position> fromJson(String json) {
    List<Position> _po = [];
    JsonDecoder decoder = new JsonDecoder();
    var data = decoder.convert(json)["list"];
    data.forEach((obj) {
      Position position = new Position(
        name : obj['name'],
        companyName : obj['companyName'],
        userName : obj['userName'],
        size : obj['size'],
        salary : obj['salary'],
        title : obj['title'],
        avatar : obj['avatar']
      );
      _po.add(position);
    });
    return _po;
  }
}