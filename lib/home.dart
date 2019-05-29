import 'package:flutter/material.dart';
import 'package:hhh/view/login_view.dart';
import 'view/position_view.dart';
import 'view/movie_view.dart';
import 'view/mine/mine_view.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomePage> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  var _tabImages;
  var _tabTitles = ['电影', '职位', '消息', '我的'];
  List<Widget> _pageList = [MoviePage(), PositionPage(), LoginPage(), MinePage()];

  @override
  void initState() {
    super.initState();
    _tabImages = [
      [getTabImage('images/tabbar_position_unselected.png'), getTabImage('images/tabbar_position_selected.png')],
      [getTabImage('images/tabbar_company_unselected.png'), getTabImage('images/tabbar_company_selected.png')],
      [getTabImage('images/tabbar_message_unselected.png'), getTabImage('images/tabbar_message_selected.png')],
      [getTabImage('images/tabbar_mine_unselected.png'), getTabImage('images/tabbar_mine_selected.png')],
    ];
  }

  Image getTabImage(String path) {
    return Image.asset(path, height: 25, width: 25,);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Image getTabIcon(int index) {
    return _currentIndex == index ? _tabImages[index][1] : _tabImages[index][0];
  }

  Text getTabTitle(int index) {
    return Text(
      _tabTitles[index],
      style: TextStyle(
          color: _currentIndex == index ? Colors.green : Colors.grey,
          fontSize: 12
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: IndexedStack(index: _currentIndex, children: _pageList,),
     bottomNavigationBar: BottomNavigationBar(
       backgroundColor: Colors.white,
       showUnselectedLabels: true,
       unselectedFontSize: 14,
       elevation: 1,
       type: BottomNavigationBarType.fixed,
       currentIndex: _currentIndex,
       items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
         BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
         BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
         BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
       ],
       onTap: (index) {
         setState(() {
           _currentIndex = index;
         });
       },
     ),
    );
  }
}