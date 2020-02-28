import "package:flutter/material.dart";
import "package:hhh/model/position_model.dart";
import "package:hhh/item/position_item.dart";

class PositionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PositionState();
  }
}

class PositionState extends State<PositionPage> {

  List<Position> _positionList = [];
  double _appBarOpacity = 1.0;
  ScrollController _scrollController = ScrollController();
  String jsonString = """
      {
        "list": [
          {
            "name": "架构师（iOS）",
            "companyName": "支付宝",
            "userName": "Ariel",
            "size": "D轮",
            "salary": "25k-45k",
            "title": "HRBP",
            "avatar": "zhifubao"
          },
          {
            "name": "高级开发工程师（Android）",
            "companyName": "京东",
            "userName": "Micheal",
            "size": "C轮",
            "salary": "18k-25k",
            "title": "HR",
            "avatar": "jingdong"
          },
          {
            "name": "JAVA开发工程师",
            "companyName": "天猫",
            "userName": "Loala",
            "size": "B轮",
            "salary": "15k-25k",
            "title": "人事经理",
            "avatar": "tianmao"
          },
          {
            "name": "PHP开发工程师",
            "companyName": "飞猪",
            "userName": "Sansa",
            "size": "B轮",
            "salary": "15k-25k",
            "title": "HR",
            "avatar": "feizhu"
          },
          {
            "name": "架构师（iOS）",
            "companyName": "支付宝",
            "userName": "Ariel",
            "size": "D轮",
            "salary": "25k-45k",
            "title": "HRBP",
            "avatar": "zhifubao"
          },
          {
            "name": "高级开发工程师（Android）",
            "companyName": "京东",
            "userName": "Micheal",
            "size": "C轮",
            "salary": "18k-25k",
            "title": "HR",
            "avatar": "jingdong"
          },
          {
            "name": "JAVA开发工程师",
            "companyName": "天猫",
            "userName": "Loala",
            "size": "B轮",
            "salary": "15k-25k",
            "title": "人事经理",
            "avatar": "tianmao"
          },
          {
            "name": "PHP开发工程师",
            "companyName": "飞猪",
            "userName": "Sansa",
            "size": "B轮",
            "salary": "15k-25k",
            "title": "HR",
            "avatar": "feizhu"
          }
        ]
      }
    """;
  void getPositionList () {
    _positionList = Position.fromJson(jsonString);
  }

  Future<Null> _onDownpullRefresh() async {
    await Future.delayed(Duration(seconds: 1),() {
      getPositionList();
      print('_onDownpullRefresh');
    });
  }

  _onScroll(offset) {
    print(offset);
    double alpha = (100-offset)/100.0;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1){
      alpha = 1;
    }
    setState(() {
      _appBarOpacity = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
        print('=======maxScrollExtent');
    getPositionList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        List<Position> tempList = Position.fromJson(jsonString);
        _positionList.addAll(tempList);
        print('=======maxScrollExtent');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("职位",),
        elevation: 0.5,
      ),
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            _onScroll(notification.metrics.pixels);
          }
        },
        child: RefreshIndicator(
          displacement: 40,
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: _positionList.length,
            itemBuilder: buildPositionItem,
            separatorBuilder: (context, index) {
              if (index == 0) {
                return Container(height: 20, color: Colors.red, child: Text('data11111'),);
              }
              else if (index == 5) {
                return Container(height: 30, color: Colors.blue, child: Text('data55555'),);
              }
              return Container(height: 0, color: Colors.green,);
            },
          ),
          onRefresh: _onDownpullRefresh,
        ),
      ),
    );
  }

  Widget buildPositionItem (BuildContext context, int index) {
    return InkWell(
      onTap: () {
        print(".........");
      },
      child: PositionItem(_positionList[index]),
    );
  }
}