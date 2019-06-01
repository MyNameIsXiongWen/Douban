import 'package:flutter/material.dart';
import 'package:hhh/utils/common.dart';
import 'package:hhh/utils/http_manager.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hhh/model/movie_detail_model.dart';

class MallPage extends StatefulWidget {
  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  List<String> _tabList = ['豆瓣豆品', '豆瓣时间'];
  List _pageList = ['images/lake.jpg', 'images/lake.jpg', 'images/lake.jpg', 'images/lake.jpg'];
  List _topIcons = [
    {'icon': 'images/mall_edu.png', 'title': '青椒学院'},
    {'icon': 'images/mall_time.png', 'title': '时间发现'},
    {'icon': 'images/mall_menu.png', 'title': '全部专栏'},
    {'icon': 'images/mall_sign.png', 'title': '签到'},
    {'icon': 'images/mall_mine.png', 'title': '我的'}
  ];
  List<MovieDetail> _goodsList = [];

  void getGoodsList() async {
    await HttpManager.get(Util.kJuheUrl, 'index?key=$kApiKey&title=哥斯拉',
        (data) {
      print(data);
      List movie = data;
      List<MovieDetail> tempList = [];
      movie.forEach((obj) {
        MovieDetail tempMovie = MovieDetail.fromJson(obj);
        tempList.add(tempMovie);
      });
      setState(() {
        _goodsList = tempList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length, initialIndex: 0);
    getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 80,
        elevation: 1,
        title: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Color(0xFF666666),
          labelColor: Colors.green,
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
          tabs: <Widget>[
            Tab(icon: Text(_tabList.first, style: TextStyle(fontSize: 16)),),
            Tab(icon: Text(_tabList.last, style: TextStyle(fontSize: 16)),)
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          buildDoubanDouPin(),
          buildDoubanTime()
        ],
      ),
    );
  }

// 豆瓣豆品
  Widget buildDoubanDouPin() {
    return ListView(
      children: <Widget>[
        _buildDPBannerView(),
        _buildDPInfoView(),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: Text('新品首发', style: TextStyle(fontSize: 15))
        ),
        _buildDPGridView()
      ],
    );
  }

  Widget _buildDPBannerView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Swiper(
        itemCount: _pageList.length,
        itemBuilder: (context, index) {
          return Image.asset(_pageList[index], fit: BoxFit.fill,);
        },
        scrollDirection: Axis.horizontal,
        autoplay: true,
        controller: SwiperController(),
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(bottom: 5, right: 30),
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey[400],
            activeColor: Util.whiteColor,
            space: 5,
            size: 5,
            activeSize: 5
          )
        ),
        onTap: (index) {
          print('点击了第$index');
        },
      ),
    );
  }

  Widget _buildDPInfoView() {
    return Container(
      color: Colors.grey[200],
      height: 60,
      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Container(
        color: Util.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('购物车'),
            Text('|'),
            Text('我的豆品'),
          ],
        ),
      )
    );
  }

  Widget _buildDPGridView() {
    return Container(
      width: MediaQuery.of(context).size.width-30,
      height: 400,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 30,
          childAspectRatio: 3/4
        ),
        itemCount: _goodsList.length,
        itemBuilder: _buildGridItem,
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Image.network(
          _goodsList[index].poster, 
          height: (MediaQuery.of(context).size.width-45)/2, 
          width: (MediaQuery.of(context).size.width-45)/2, 
          fit: BoxFit.cover,
        ),
        Text(_goodsList[index].year)
      ],
    );
  }

//豆瓣时间
  Widget buildDoubanTime() {
    return ListView(
      children: <Widget>[
        _buildSJBannerView(),
        _buildDPTopIconView()
      ],
    );
  }

  Widget _buildSJBannerView() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 25),
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: Swiper(
        itemCount: _pageList.length,
        itemBuilder: _swiperBuilder,
        scrollDirection: Axis.horizontal,
        autoplay: true,
        controller: SwiperController(),
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 5),
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey[400],
            activeColor: Util.whiteColor,
            space: 5,
            size: 5,
            activeSize: 8
          )
        ),
        onTap: (index) {
          print('点击了第$index');
        },
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    // return Image.asset(_pageList[index], fit: BoxFit.fill,);
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(_pageList[index], fit: BoxFit.fill,),
      ),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: NetworkImage('http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg'),//pageList[index]
      //     fit: BoxFit.fill
      //   ),
      //   borderRadius: BorderRadius.all(Radius.circular(10))
      // ),
    );
  }

  Widget _buildDPTopIconView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _topIcons.map((json) {
        return InkWell(
          onTap: () {
            print('object');
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                json['icon'],
                height: 40,
              ),
              Text(
                json['title'],
                style: TextStyle(
                  color: Color(0xFF707070),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}