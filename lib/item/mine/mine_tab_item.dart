import 'package:flutter/material.dart';

class MineTabItem extends StatefulWidget {
  @override
  _MineTabItemState createState() => _MineTabItemState();
}

class _MineTabItemState extends State<MineTabItem> {
  ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(15),
            child: Text('我的书影音', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          ),
          buildItemTab(),
          Container(
            height: 0.1,
            color: Color(0xFF707070),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                childAspectRatio: 6/5
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 9,
              itemBuilder: (context, index) {
                int tag = index ~/ 3+ 1;
                return Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    children: <Widget>[
                      Image.asset('images/mine_cover$tag.png', height: 40,),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('想看 $tag', style: TextStyle(fontSize: 13),),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildItemTab() {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 15),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildMovieShowBtn('影视', 0),
                buildMovieShowBtn('图书', 1),
                buildMovieShowBtn('音乐', 2)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMovieShowBtn(String title, int tag) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 13,
                      color: tag == _currentIndex ? Colors.black : Color(0xFF707070),
                      fontWeight: tag == _currentIndex ? FontWeight.w500 : FontWeight.w300))),
          Container(
              color: tag == _currentIndex ? Colors.black : Colors.transparent,
              width: 30,
              height: 2)
        ],
      ),
      onTap: () {
        _scrollController.animateTo(
          tag*(79.0*3), duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn
        );
        setState(() {
          _currentIndex = tag;
        });
      },
    );
  }
}