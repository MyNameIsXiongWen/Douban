import 'package:flutter/material.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:hhh/utils/custom_route.dart';
import 'package:hhh/view/login_view.dart';
import 'package:hhh/item/mine/mine_default_item.dart';
import 'package:hhh/item/mine/mine_tab_item.dart';
import 'package:hhh/view/movie_detail_view.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  double _appBarOpacity = 0.0;
  List _contentList = [[], [{'icon': 'mine_movie', 'title': '看电影'}], [{'icon': 'mine_publish', 'title': '我的发布'}, {'icon': 'mine_attention', 'title': '我的关注'}, {'icon': 'mine_photo', 'title': '相册'}, {'icon': 'mine_collect', 'title': '豆列/收藏'}]];

  _onScroll(offset) {
    print(offset);
    double alpha = offset / (MediaQuery.of(context).padding.top + 44);
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1){
      alpha = 1;
    }
    setState(() {
      _appBarOpacity = alpha;
    });
  }

  presentToLoginView() {
    Navigator.of(context).push(CustomRoutePresent(LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification && notification.metrics.axis == Axis.vertical) {
                _onScroll(notification.metrics.pixels);
              }
            },
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: SectionTableView(
                sectionCount: 3,
                numOfRowInSection: (section) {
                  if (section == 2) {
                    return 4;
                  }
                  return 1;
                },
                headerInSection: (section) {
                  if (section > 0) {
                    return Container(color: Colors.grey[200], height: 10,);
                  }
                  else {
                    return buildTableHeaderView();
                  }
                },
                cellAtIndexPath: (section, row) {
                  if (section > 0) {
                    return InkWell(
                      child: MineDefaultItem(_contentList[section][row]),
                      onTap: () => presentToLoginView()
                    );
                  }
                  return MineTabItem();
                },
              ),
            )
          ),
          Opacity(
            opacity: _appBarOpacity < 1 ? 0 : 1,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: whiteColor,
              height: MediaQuery.of(context).padding.top + 44,
              width: MediaQuery.of(context).size.width,
              child: Text('我的', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).padding.top+10,
            child: Container(
              child: GestureDetector(
                child: Image.asset(_appBarOpacity < 1 ? 'images/setting_white.png' : 'images/setting_black.png', height: 25,),
                onTap: () => presentToLoginView(),
              ),
            ),
          )
        ],
      )
    );
  }

  Widget buildTableHeaderView() {
    return Container(
      color: Colors.green,
      height: MediaQuery.of(context).padding.top + 210,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 60 + MediaQuery.of(context).padding.top),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 150,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 40,
                          color: whiteColor,
                          child: Text('登录 / 注册', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.green[900]),)
                        )
                      ),
                    onTap: () => presentToLoginView(),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Image.asset('images/wechat.png', height: 40,),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text('微信登录', style: TextStyle(color: whiteColor, fontSize: 11)),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Image.asset('images/sina.png', height: 40,),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text('微博登录', style: TextStyle(color: whiteColor, fontSize: 11)),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(color: Colors.grey[200], height: 20,)
        ],
      ),
    );
  }
}