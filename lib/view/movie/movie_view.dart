import 'package:flutter/material.dart';
import 'package:hhh/utils/common.dart';
import 'package:hhh/utils/custom_route.dart';
import 'package:hhh/utils/http_manager.dart';
import 'package:hhh/model/movie_model.dart';
import 'package:hhh/item/movie_item.dart';
import 'movie_detail_view.dart';
import 'search_view.dart';

class MoviePage extends StatefulWidget {
  @override
  MoviePageState createState() => new MoviePageState();
}

class MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List _navTabTitles = ['电影', '电视', '综艺', '读书', '音乐', '同城'];
  List _topIcons = [
    {'icon': 'images/search_home.png', 'title': '找电影'},
    {'icon': 'images/ranking_home.png', 'title': '豆瓣榜单'},
    {'icon': 'images/card_home.png', 'title': '豆瓣猜'},
    {'icon': 'images/movie_home.png', 'title': '豆瓣片单'}
  ];
  List<Movie> _movieList = [];
  bool _movieShowed = true;
  String _movieCount = '4';
  TextEditingController _searchTextCtrl = TextEditingController();

  void getTodayMovieList() async {
    HttpManager.get(Util.kJuheUrl, 'movies.today?key=' + kApiKey + '&cityid=' + kCityId,
        (data) {
      print(data);
      List movie = data;
      List<Movie> tempList = [];
      movie.forEach((obj) {
        Movie tempMovie = Movie.fromJson(obj);
        tempList.add(tempMovie);
      });
      setState(() {
        _movieList = tempList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this, initialIndex: 0, length: _navTabTitles.length);
    getTodayMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            buildMovieView(),
            buildMovieView(),
            buildMovieView(),
            buildMovieView(),
            buildMovieView(),
            buildMovieView()
          ],
        ),
      ),
      // body: NestedScrollView(
      //   headerSliverBuilder: _sliverBuilder,
      //   body: Center(
      //     child: ListView.builder(
      //       itemBuilder: _itemBuilder,
      //       itemCount: 15,
      //     ),
      //   ),
      // )
      // body: Padding(
      //   padding: const EdgeInsets.all(15.0),
      //   child: TabBarView(
      //     controller: _tabController,
      //     children: <Widget>[
      //       buildMovieView(),
      //       buildMovieView(),
      //       buildMovieView(),
      //       buildMovieView(),
      //       buildMovieView(),
      //       buildMovieView()
      //     ],
      //   ),
      // ),
      // )
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      leading: Icon(Icons.phone_iphone),
      title: Text('无与伦比的标题+$index'),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        centerTitle: true, //标题居中
        expandedHeight: 100.0, //展开高度
        floating: false, //不随着滑动隐藏标题
        pinned: true, //固定在顶部
        elevation: 1,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(bottom: 0),
          background: buildAppBarTitle(),
          title: buildAppBarBottom(),
        ),
      ),
    ];
  }

  Widget buildAppBar() {
    return AppBar(
      title: buildAppBarTitle(),
      bottom: buildAppBarBottom(),
    );
  }

  Widget buildAppBarTitle() {
    return Container(
      // padding: EdgeInsets.only(left: 15, right: 15),
      height: 64,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 30,
              color: Color(0xFFf5f5f5),
            ),
          ),
          Positioned(
            left: 10,
            child: Image.asset(
              'images/search_default.png',
              height: 23,
            ),
          ),
          Positioned(
            left: 40,
            child: Container(
                width: MediaQuery.of(context).size.width - 30 - 80,
                height: 30,
                child: TextField(
                  controller: _searchTextCtrl,
                  maxLines: 1,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      hintText: '电影当中打动你的告白瞬间',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 5)),
                  style: TextStyle(fontSize: 14),
                  onChanged: (content) {
                    print(content);
                  },
                  onTap: () => Navigator.of(context).push(CustomRouteNoAnimation(SearchPage()),),
                )),
          ),
          Positioned(
            right: 10,
            child: GestureDetector(
              child: Image.asset(
                'images/scan_default.png',
                height: 23,
              ),
              onTap: () {
                print('======scan' + _searchTextCtrl.text);
                _searchTextCtrl.clear();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildAppBarBottom() {
    return TabBar(
      controller: _tabController,
      isScrollable: false,
      indicatorColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.black,
      unselectedLabelColor: Color(0xFF707070),
      tabs: _navTabTitles.map((title) {
        return Tab(
          text: title,
        );
      }).toList(),
    );
  }

  Widget buildMovieView() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        buildTopIconView(),
        buildMovieTab(),
        Container(
          height: 0.2,
          color: Color(0xFF707070),
          margin: EdgeInsets.only(bottom: 20),
        ),
        buildMovieGridView()
      ],
    );
  }

  Widget buildTopIconView() {
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
                height: 50,
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

  Widget buildMovieTab() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width - 30,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 160,
            // height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildMovieShowBtn('影院热映', _movieShowed),
                buildMovieShowBtn('即将上映', !_movieShowed)
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              child: Text('全部  ' + _movieCount + ' >'),
            ),
          )
        ],
      ),
    );
  }

  Widget buildMovieGridView() {
    return Container(
      child: _movieList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 6),
              shrinkWrap: true,
              primary: false,
              itemCount: _movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MovieDetailView(
                              movieId: _movieList[index].movieId,
                            )));
                  },
                  child: MovieItem(
                    movie: _movieList[index],
                    clickContent: () {
                    print('=======${_movieList[index].movieName}');
                    },
                  )
                );
              },
            ),
    );
  }

  Widget buildMovieShowBtn(String title, bool tag) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 18,
                      color: tag ? Colors.black : Color(0xFF707070),
                      fontWeight: tag ? FontWeight.w500 : FontWeight.w300))),
          Container(
              color: tag ? Colors.black : Colors.transparent,
              width: 75,
              height: 2)
        ],
      ),
      onTap: () {
        setState(() {
          _movieShowed = !_movieShowed;
          _movieCount = _movieShowed
              ? _topIcons.length.toString()
              : _navTabTitles.length.toString();
        });
        print(title);
      },
    );
  }
}
