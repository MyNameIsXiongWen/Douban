import 'package:flutter/material.dart';

class MineDefaultItem extends StatelessWidget {
  final Map<String, String> content;
  MineDefaultItem(this.content);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      padding: EdgeInsets.only(left: 15, right: 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset('images/' + content['icon'] + '.png', height: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15,),
                  child: Text(content['title']),
                )
              ),
              Image.asset('images/arrow_right.png', height: 40),
            ],
          ),
          Divider(height: 0.1, color: Color(0xFF999999),)
        ],
      )
    );
  }
}