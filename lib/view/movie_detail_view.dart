import 'package:flutter/material.dart';
import 'package:hhh/utils/http_manager.dart';
import 'package:hhh/model/movie_detail_model.dart';

const Color whiteColor = Colors.white;
const double rateWidth = 120.0;
const double startSize = 8.0;

class MovieDetailView extends StatefulWidget {
  final String movieId;
  MovieDetailView({Key key, @required this.movieId}) : super(key: key);

  @override
  _MovieDetailViewState createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> with SingleTickerProviderStateMixin {
  MovieDetail _movieDetail;
  TabController _tabController;

  getMovieDetailRequest() {
    HttpManager.get('http://v.juhe.cn/movie/query',
        'key=' + kApiKey + '&movieid=' + widget.movieId, (data) {
      print(data);
      setState(() {
        _movieDetail = MovieDetail.fromJson(data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        
      });
    });
    getMovieDetailRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('电影'),
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 0, 215, 198),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.share),tooltip: 'share',onPressed: () {},),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 215, 198),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: ListView(
            children: <Widget>[
              buildMovieBaseInfo(),
              buildRemindView(),
              buildRateView(),
              buildPlotSimple(),
              buildActors(),
              buildTabController()
            ],
          ),
        ),
      ),
    );
  }

//顶部电影基础信息
  Row buildMovieBaseInfo() {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 130,
          margin: EdgeInsets.only(right: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: FadeInImage.assetNetwork(
              placeholder: 'images/placeholder.png',
              image: _movieDetail.poster,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          width: 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _movieDetail.title,
                style: TextStyle(
                    fontSize: 20.0,
                    color: whiteColor,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, bottom: 6.0),
                child: Text(
                  _movieDetail.alsoKnownAs + '(' + _movieDetail.movieId + ')',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: whiteColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                _movieDetail.country +
                    ' / ' +
                    _movieDetail.genres +
                    ' / ' +
                    '上映 / 片长' +
                    _movieDetail.runtime +
                    _movieDetail.alsoKnownAs,
                style: TextStyle(fontSize: 11.0, color: whiteColor),
                softWrap: true,
                textAlign: TextAlign.left,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    buildRectItem(0, '想看'),
                    buildRectItem(16, '看过'),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildRectItem(double marginLeft, String title) {
    return Container(
      decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(3.0)),
      margin: EdgeInsets.only(left: marginLeft),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      width: 107,
      height: 40,
      alignment: Alignment.center,
    );
  }

//看过与否提示页
  Container buildRemindView() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5.0)),
      margin: EdgeInsets.only(top: 15.0),
      padding:
          EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
      width: 345,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 240,
            child: Row(
              children: <Widget>[
                Text(
                  '已看过？记录此刻感受',
                  style: TextStyle(color: whiteColor, fontSize: 13),
                ),
                Container(width: 20),
                Image.asset(
                  'images/rate_empty.png',
                  height: 15,
                ),
              ],
            ),
          ),
          Positioned(
            right: -10,
            child: Image.asset(
              'images/arrow_right.png',
              height: 25,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

//  评分
  Widget buildRateView() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.only(top: 15.0),
        padding:
            EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
        width: 345,
        child: Column(
          children: <Widget>[
            Container(
              height: 20,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Text('豆瓣评分™',
                            style:
                                TextStyle(color: whiteColor, fontSize: 11.0))),
                    Image.asset(
                      'images/arrow_right.png',
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ]),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 40, right: 15),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _movieDetail.rating,
                        style: TextStyle(
                            fontSize: 30,
                            color: whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Image.asset(
                        'images/rate_full.png',
                        height: 15,
                        width: 60,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: rateWidth + startSize * 5 + 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      buildRateStack(170, 5),
                      buildRateStack(370, 4),
                      buildRateStack(230, 3),
                      buildRateStack(70, 2),
                      buildRateStack(90, 1),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _movieDetail.ratingCount + '人评分',
                          style: TextStyle(color: whiteColor, fontSize: 8.0),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              width: 325,
              height: 0.2,
              color: whiteColor,
              margin: EdgeInsets.only(top: 5, bottom: 5),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                '372人看过  638人想看',
                style: TextStyle(color: whiteColor, fontSize: 10.0),
              ),
            )
          ],
        ));
  }

//  评分进度栏
  Row buildRateStack(double count, int starCount) {
    return Row(
      children: <Widget>[
        Container(
          width: starCount * startSize,
          height: startSize,
          margin: EdgeInsets.only(left: (5 - starCount) * startSize, right: 5),
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              itemCount: starCount,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  'images/star.png',
                  height: startSize,
                  width: startSize,
                );
              }),
        ),
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(2.0)),
              width: rateWidth,
              height: 6,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.orange[400],
                  borderRadius: BorderRadius.circular(2.0)),
              width: count / double.parse(_movieDetail.ratingCount) * rateWidth,
              height: 6,
            ),
          ],
        )
      ],
    );
  }

//  简介
  Container buildPlotSimple() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              '剧情简介',
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            _movieDetail.plotSimple,
            style: TextStyle(color: whiteColor, fontSize: 13),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

//  演员表
  Column buildActors() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 25, bottom: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '演职员',
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '全部 ' + _movieDetail.actors.split(',').length.toString(),
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
              Image.asset(
                'images/arrow_right.png',
                height: 25,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Container(
          height: 130,
          width: 345,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 130/75,
                mainAxisSpacing: 15,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _movieDetail.actorsToList().length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(3.0)
                      ),
                      width:75,
                      height: 100,
                    ),
                    Text(
                      _movieDetail.actorsToList()[index],
                      style: TextStyle(color: whiteColor, fontSize: 13, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              }
          ),
        )
      ],
    );
  }
  
  Widget buildTabController() {
    return Column(
      children: <Widget>[
        Container(
          width: 200,
          height: 40,
          child: TabBar(
            controller: _tabController,
            indicatorColor: whiteColor,
            isScrollable: false,
            labelPadding: EdgeInsets.all(0),
            tabs: <Widget>[
              Tab(child: Text('电影', style: TextStyle(color: whiteColor),)),
              Tab(child: Text('片单', style: TextStyle(color: whiteColor),))
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width-30,
          height: 50,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(child: Text("TabbarView11111", style: TextStyle(color: whiteColor),),),
              Center(child: Text("TabbarView22222", style: TextStyle(color: whiteColor),),),
            ],
          ),
        )
      ], 
    );
  }
}
