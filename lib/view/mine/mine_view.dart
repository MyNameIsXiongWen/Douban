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

  List _contentList = [[], [{'icon': 'mine_movie', 'title': '看电影'}], [{'icon': 'mine_publish', 'title': '我的发布'}, {'icon': 'mine_attention', 'title': '我的关注'}, {'icon': 'mine_photo', 'title': '相册'}, {'icon': 'mine_collect', 'title': '豆列/收藏'}]];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        elevation: 0,
      ),
      body: SectionTableView(
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
            return Container(
              color: Colors.grey[200],
              height: 270,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 40),
                              alignment: Alignment.center,
                              width: 150,
                              height: 40,
                              color: whiteColor,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Text('登录 / 注册')
                              ),
                            ),
                            onTap: () => presentToLoginView(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(color: Colors.grey[200], height: 20,)
                ],
              ),
            );
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
    );
  }

  presentToLoginView() {
    Navigator.of(context).push(CustomRoutePresent(LoginPage()));
  }
}