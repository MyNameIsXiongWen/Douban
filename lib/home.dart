import 'package:flutter/material.dart';
import 'view/position_view.dart';
import 'view/movie_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomePage> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  TabController _tabController;
  VoidCallback onChanged;
  var _tabImages;
  var _tabTitles = ['职位', '公司', '消息', '我的'];
  var _pageList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _tabController.addListener(onChanged);
    onChanged = () {
      setState(() {
        _currentIndex = this._tabController.index;
      });
    };
    _tabImages = [
      [getTabImage('images/tabbar_position_unselected.png'), getTabImage('images/tabbar_position_selected.png')],
      [getTabImage('images/tabbar_company_unselected.png'), getTabImage('images/tabbar_company_selected.png')],
      [getTabImage('images/tabbar_message_unselected.png'), getTabImage('images/tabbar_message_selected.png')],
      [getTabImage('images/tabbar_mine_unselected.png'), getTabImage('images/tabbar_mine_selected.png')],
    ];
    _pageList.add(new MoviePage());
    _pageList.add(new PositionPage());
    _pageList.add(new PositionPage());
    _pageList.add(new PositionPage());
  }

  Image getTabImage(String path) {
    return Image.asset(path, height: 25, width: 25,);
  }

  @override
  void dispose() {
    _tabController.removeListener(onChanged);
    _tabController.dispose();
    super.dispose();
  }

  Image getTabIcon(int index) {
    return _currentIndex == index ? _tabImages[index][1] : _tabImages[index][0];
  }

  Text getTabTitle(int index) {
    return Text(
      _tabTitles[index],
      style: TextStyle(
          color: _currentIndex == index ? Theme.of(context).primaryColor : Colors.grey,
          fontSize: 12
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      body: _pageList[_currentIndex],
//      bottomNavigationBar: new BottomNavigationBar(
//        backgroundColor: Colors.white,
//        items: <BottomNavigationBarItem>[
//          new BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
//          new BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
//          new BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
//          new BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
//        ],
//        type: BottomNavigationBarType.fixed,
//        currentIndex: _currentIndex,
//        onTap: (index) {
//          setState(() {
//            _currentIndex = index;
//          });
//        },
//      ),
      body: TabBarView(
        children: <Widget>[
          new MoviePage(), new PositionPage(), new PositionPage(), new PositionPage()
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        child: TabBar(
          controller: _tabController,
          tabs: <Tab>[
            new Tab(icon: getTabIcon(0),text: _tabTitles[0],),
            new Tab(icon: getTabIcon(1),text: _tabTitles[1],),
            new Tab(icon: getTabIcon(2),text: _tabTitles[2],),
            new Tab(icon: getTabIcon(3),text: _tabTitles[3],),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}