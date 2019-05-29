import 'package:flutter/material.dart';
// import 'package:hhh/utils/custom_route.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  // 列表项
  Widget _buildListItem(BuildContext context, int index){
    return ListTile(
      title: Text('list tile index $index')
    );
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              color: Colors.green,
              height: 200,
              child: Text('headerview'),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(_buildListItem, childCount: 15),
            itemExtent: 40,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.green,
              height: 200,
              child: Text('footerview'),
            ),
          ),
        ],
      ),
    );
  }
}