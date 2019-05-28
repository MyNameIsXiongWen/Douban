import 'package:flutter/material.dart';
import 'package:hhh/model/position_model.dart';

class PositionItem extends StatelessWidget {

  final Position position;
  PositionItem(this.position);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: Text(position.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
              Text(position.salary, style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 215, 198)),)
            ]
      ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(position.companyName + '  ' + position.size, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),)
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('images/' + position.avatar +  '.png', height: 25, width: 25,),
                Container(
                  padding: EdgeInsets.only(top: 6),
                  child: Text('  ' + position.userName + ' · ' + position.title, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11.0),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}